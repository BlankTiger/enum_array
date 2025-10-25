Enum_Array :: struct(Enum: Type, Value: Type) {
    backing_array: [#run enum_highest_value(Enum) + 1]Value;
}

operator *[] :: (ea: *Enum_Array($E, $V), index: E) -> *V {
    #assert(type_info(E).type == .ENUM);
    idx := get_enum_value(*index, xx E);
    return *ea.backing_array[idx];
}

for_expansion :: (ea: *Enum_Array($E, $V), body: Code, flags: For_Flags) #expand {
    values := enum_values_as_enum(E);
    for *=cast(bool)(flags & .POINTER), <=cast(bool)(flags & .REVERSE)  index: values {
        idx       := get_enum_value(*index, xx E);
        `it       := ea.backing_array[idx];
        `it_index := index;

        #insert body;
    }
}

#import "Basic";
#import "Reflection";
