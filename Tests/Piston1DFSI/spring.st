// Units: g, mm, s

under Spring {
  Stiffness = 37500.0; //g/s^2
  Mass = 0.002; //g
}

under Time {
  TimeStepSize = 2e-7;
  MaxTime = 0.005;
}

under Output {
  Prefix = "results/";
  Mesh = "surface.top";
  Displacement = "displacement.top";
  TimeInterval = 4e-5;

  under Probe[0] {
    NodeId = 0;
    Displacement = "disp.0";
    Force = "force.0";
    Velocity = "velo.0";
    Frequency = 30;
  }

  VerboseScreenOutput = Low;
}
