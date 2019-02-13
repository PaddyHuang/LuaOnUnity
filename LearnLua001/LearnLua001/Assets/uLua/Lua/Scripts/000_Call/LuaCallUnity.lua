luanet.load_assembly("UnityEngine")
GameObject = luanet.import_type("UnityEngine.GameObject")
Debug = luanet.import_type("UnityEngine.Debug")

function myPrint(  )
	Debug.Log(gameObject.name)
end