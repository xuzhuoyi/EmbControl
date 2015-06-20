//
//  LDECloud.swift
//  embcontrol
//
//  Created by 徐卓异 on 15/6/20.
//  Copyright © 2015年 LDE Team. All rights reserved.
//

import Foundation
import Darwin.C

class LDECloud {
    func testtcpclient() -> String {
        //创建socket
        let client:TCPClient = TCPClient(addr: "104.194.77.197", port: 9000)
        //连接
        var (success,errmsg)=client.connect(timeout: 10)
        if success{
            //发送数据
            var (success,errmsg)=client.send(str:"ver" )
            if success{
                //读取数据
                let data=client.read(1024*10)
                if let d=data{
                    if let str=String(bytes: d, encoding: NSUTF8StringEncoding){
                        return str
                    }
                }
            }else{
                return errmsg
            }
        }else{
            return errmsg
        }
        return "Error"
    }
    func echoService(client c:TCPClient){
        print("newclient from:\(c.addr)[\(c.port)]")
        let d=c.read(1024*10)
        c.send(data: d!)
        c.close()
    }
    func testtcpserver(){
        let server:TCPServer = TCPServer(addr: "127.0.0.1", port: 8080)
        var (success,msg)=server.listen()
        if success{
            while true{
                if let client=server.accept(){
                    echoService(client: client)
                }else{
                    print("accept error")
                }
            }
        }else{
            print(msg)
        }
    }
    //testclient()
    func testudpserver(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            let server:UDPServer=UDPServer(addr:"127.0.0.1",port:8080)
            let run:Bool=true
            while run{
                var (data,remoteip,remoteport)=server.recv(1024)
                print("recive")
                if let d=data{
                    if let str=String(bytes: d, encoding: NSUTF8StringEncoding){
                        print(str)
                    }
                }
                print(remoteip)
                server.close()
                break
            }
        })
    }
    func testudpclient(){
        let client:UDPClient=UDPClient(addr: "localhost", port: 8080)
        print("send hello world")
        client.send(str: "hello world")
        client.close()
    }

}
