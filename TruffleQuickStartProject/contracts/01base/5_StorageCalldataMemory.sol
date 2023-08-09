// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


// memory、calldata、storage，他们只能修饰引用数据类型的变量，比如数组、字符串、字节、结构体等
// memory 适用于方法传参、返参和方法体内使用，使用完就会清除掉，释放内存
// calldata 适用于方法传参，而且该变量的值不能改变
// storage  它的指针必须指向链上数据。使用完，链上数据将保存为最新状态
contract StorageCalldataMemory {
// 某个账户有10，可以转账10吗，手续费呢？？？
}