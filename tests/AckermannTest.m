classdef AckermannTest < matlab.unittest.TestCase
    %ACKERMANNTEST  Unit tests for the steering-geometry functions.
    %   Run with:  buildtool test

    properties
        L  = 3.5    % wheelbase [m]
        t  = 1.75   % front track [m]
        do          % outer-wheel sweep [rad]
    end

    methods (TestClassSetup)
        function addSource(tc)
            root = fileparts(fileparts(mfilename("fullpath")));
            tc.applyFixture(matlab.unittest.fixtures.PathFixture(fullfile(root, "src")));
            tc.do = deg2rad(linspace(0.5, 20, 400));
        end
    end

    methods (Test)
        function pureAckermannSatisfiesGeometry(tc)
            % Classic Ackermann condition: cot(do) - cot(di) = t / L
            di = ackermann_curves(tc.do, 1, tc.L, tc.t);
            tc.verifyEqual(cot(tc.do) - cot(di), repmat(tc.t/tc.L, size(tc.do)), "AbsTol", 1e-10);
        end

        function innerWheelSteersMoreUnderPureAckermann(tc)
            di = ackermann_curves(tc.do, 1, tc.L, tc.t);
            tc.verifyTrue(all(di > tc.do));
        end

        function parallelSteeringIsIdentity(tc)
            tc.verifyEqual(ackermann_curves(tc.do, 0, tc.L, tc.t), tc.do, "AbsTol", 1e-15);
        end

        function antiAckermannMirrorsPure(tc)
            pure = ackermann_curves(tc.do, 1, tc.L, tc.t);
            anti = ackermann_curves(tc.do, -1, tc.L, tc.t);
            tc.verifyEqual(anti - tc.do, -(pure - tc.do), "AbsTol", 1e-12);
        end

        function pureAckermannSlipIsNearZero(tc)
            % Residual comes only from the bicycle-model radius approximation
            di = ackermann_curves(tc.do, 1, tc.L, tc.t);
            [si, so] = slip_angle_calc(di, tc.do, tc.L, tc.t);
            tc.verifyLessThan(max(abs(rad2deg([si so]))), 0.25);
        end

        function parallelSteeringScrubsInnerTyre(tc)
            [si, so] = slip_angle_calc(tc.do, tc.do, tc.L, tc.t);
            tc.verifyTrue(all(si < 0) && all(so > 0));
        end

        function linearTyreSignConvention(tc)
            % SAE/ISO: positive slip -> negative lateral force
            tc.verifyEqual(tyre_lateral_force(deg2rad(1), 50e3), -50e3*deg2rad(1), "RelTol", 1e-12);
            tc.verifyEqual(tyre_lateral_force(0, 50e3), 0);
        end
    end
end
