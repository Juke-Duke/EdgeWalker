# Modules

## Defining a Module

Modules are the highest order of grouping code in Edge. It provides a way to group logical code together without defining a type instance to use them.

Every file but the program file must define a top level module. All code written in the file belong to that module.

*`Modules.edge`*
```
module TopLevelModule;

var x = 10; // Global variable `TopLevelModule.x`
```

## Submodules

All other defined modules after the top level module are know as submodules, and must be block scoped.

*`Modules.edge`*
```
module TopLevelModule;

var x: int32 = 10;

module SubModule
{
    module InnerSubModule
    {
        var x: int32 = 20; // Global variable `TopLevelModule/SubModule/InnerSubModule.x`
    }
}
```

You canreduce nesting by specifying the targeted module as such:

*`Modules.edge`*
```
module TopLevelModule;

var x: int32 = 10;

module SubModule/InnerSubModule
{
    var x: int32 = 20; // Global variable `TopLevelModule/SubModule/InnerSubModule.x`
}
```

## Importing Modules

To use a module in another file, you use the `edge` keyword to do so.

*`Program.edge`*
```
edge TopLevelModule;

var x = TopLevelModule.x;
```

If you want to use code from a submodule, one way is to state the full name.

*`Program.edge`*
```
edge TopLevelModule;

var x = TopLevelModule/SubModule/InnerSubModule.x;
```

To reduce verbosity, you can import the full name of the specified submodule.

*`Program.edge`*
```
edge TopLevelModule/SubModule/InnerSubModule;

var x = InnerSubModule.x;
```

x = 
