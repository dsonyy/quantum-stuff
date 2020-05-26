import qsharp

from qsharp import Result
from Quantum.Bell import Test, Test2

initials = (Result.Zero, Result.One)

for i in initials:
    """
    res = Test.simulate(count=1000, initial=i)
    (num_zeros, num_ones) = res
    print(f'Init:{i: <4} 0s={num_zeros: <4} 1s={num_ones: <4}')
    """
    res = Test2.simulate(count=1000, initial=i)
    (num_zeros, num_ones, agree) = res
    print(f'Init:{i: <4} 0s={num_zeros: <4} 1s={num_ones: <4} agree={agree: <4}')