namespace Quantum.Bell {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    // 'operation' is a subroutine with any quantum stuff
    operation Set(desired : Result, q1 : Qubit) : Unit { // 'Unit' is like void
        if (desired != M(q1)) { // M() - measurement
            X(q1); // X() - flips the state of the qubit
        }
    }

    operation Test(count : Int, initial : Result) : (Int, Int) {
        mutable numOnes = 0;
        using (qubit = Qubit()) {
            for (test in 1..count) {
                Set(initial, qubit);
                // X(qubit);
                H(qubit); // Hadamard gate - 50% |0>, 50% |1> probability
                let res = M(qubit);
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit); // after quiting 'using' we have to assign Zero to qubit
        }
        return (count - numOnes, numOnes); // number of |0>'s and |1>'s
    }
    
    operation Test2(count : Int, initial : Result) : (Int, Int, Int) {
        mutable numOnes = 0;
        mutable agree = 0;
        using ((q0, q1) = (Qubit(), Qubit())) {
            for (test in 1..count) {
                Set(initial, q0);
                Set(Zero, q1);
                H(q0);
                CNOT(q0, q1); // Controlled-Not gate
                let res = M(q0);
                if (M(q1) == res) {
                    set agree += 1;
                }
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, q0);
            Set(Zero, q1);
        }
        return (count - numOnes, numOnes, agree);
    }
}