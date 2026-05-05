// Units: g, mm, s

under ConcurrentPrograms {
  under AeroS {
    FSIAlgorithm = ByAeroS;
  }
}

under Mesh {
  Type = ThreeDimensional;
  X0   = -500.0;
  Xmax =  2500.0;
  Y0   =  -0.5;
  Ymax =   0.5;
  Z0   =  -0.5;
  Zmax =   0.5;

  under ControlPointX[0] {Coordinate = -500.0; CellWidth = 2.5;}
  under ControlPointX[1] {Coordinate = 200.0; CellWidth = 0.5;}
  under ControlPointX[2] {Coordinate = 1800.0; CellWidth = 0.5;}
  under ControlPointX[3] {Coordinate = 2500.0; CellWidth = 2.5;}

  NumberOfCellsY = 1;
  NumberOfCellsZ = 1;

  BoundaryConditionX0   = Outlet;
  BoundaryConditionXmax = Outlet;
  BoundaryConditionY0   = Symmetry;
  BoundaryConditionYmax = Symmetry;
  BoundaryConditionZ0   = Symmetry;
  BoundaryConditionZmax = Symmetry;
}


under EmbeddedBoundaryMethod {
  RiemannNormal = Mesh; //Average;
  ReconstructionAtInterface = Constant;
  under EmbeddedSurfaces {
    under Surface[0] {
      SurfaceProvidedByAnotherSolver = Yes;
      SurfaceThickness = 1.0e-6;
      GaussQuadrature = OnePoint;
      GaussPointsLofting = 0.2; //non-D, w.r.t. local element size
      InternalPressure = 0.0;
      ConstantReconstructionDepth = 6.0; //dimensional (distance)

      // write surface pressures for interpolations
      under Output {
        Frequency = 1000;
        Prefix = "results/";
        Mesh = "surface_fluid.top";
        Displacement = "surface_fluid_disp.txt";
        Solution = "surface_fluid_load.txt"; 
      }
    }
  }
}


under Equations {

  //...Material 0: air
  under Material[0]{
    EquationOfState = StiffenedGas;
    under StiffenedGasModel{
      SpecificHeatRatio = 1.4;
      PressureConstant = 0.0;
    }
    //PressureCutOff = 1.0;
    //DensityCutOff  = 1.0e-11;
  }

}

under InitialCondition {

  UserDefinedStateCalculator = "./UserDefinedState.so";

  //under GeometricEntities {

  //  under Point[0] {
  //    X = 500;
  //    under InitialState {
  //      MaterialID = 0;
  //      Density = 1.225e-6;
  //      VelocityX = 0.0;
  //      Pressure = 1e5;
  //    }
  //  }

  //}

}

under BoundaryConditions {

}

under Space {

  under NavierStokes {
    Flux = LocalLaxFriedrichs; //HLLC; //LocalLaxFriedrichs; //Roe; 
    under Reconstruction {
      Type = Linear;    
      VariableType = ConservativeCharacteristic;
      SlopeNearInterface = Zero;
      Limiter = GeneralizedMinMod;
      GeneralizedMinModCoefficient = 1.0;
    }
  }

}

under Time {
  Type = Explicit;
  MaxTime = 5.0e-1;
  CFL = 0.9;
  under Explicit {
    Type = RungeKutta3; 
  }
}

under Output {
  Prefix = "results/";
  Solution = "solution";
  TimeInterval = 4.0e-5;
  Density = On;
  Velocity = On;
  Pressure = On;
  InternalEnergyPerUnitMass = On;
  MaterialID = On;
  VerboseScreenOutput = Medium; //Low //High

  under LinePlot[0] {
    FileName = "line";
    NumberOfPoints = 1500;
    TimeInterval = 4.0e-5;
    X0   = 0.0;    Y0 = 0.0;   Z0 = 0.0;
    Xmax = 2000.0; Ymax = 0.0; Zmax = 0.0;
  }
}
