Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSIFHry>; Fri, 6 Sep 2002 03:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSIFHry>; Fri, 6 Sep 2002 03:47:54 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:7865 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318426AbSIFHrx>; Fri, 6 Sep 2002 03:47:53 -0400
Message-ID: <20020906075227.31086.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Date: Fri, 06 Sep 2002 15:52:27 +0800
Subject: Re: BYTE UNIX Benchmarks (Version 4.1.0)
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what is happening,
my apologies for these mangled emails.
This should be the more intersting part of
the test I've ran on the last -aa kernel.

                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)             210515.1   210513.7       10.0
Arithmetic Test (type = float)              210516.4   210471.8       10.0
Arithmetic Test (type = int)                200121.7   200129.4       10.0
Arithmetic Test (type = long)               200131.7   200123.6       10.0
Arithmetic Test (type = short)              203544.0   203506.7       10.0
Arithoh                                    3664143.2  3664144.7       10.0
C Compiler Throughput                          469.7      468.7       10.0
Dc: sqrt(2) to 99 decimal places             42687.3    42615.1       10.0
Double-Precision Whetstone                     417.4      417.8       10.0
Execl Throughput                               975.8      933.3        9.6
File Copy 1024 bufsize 2000 maxblocks        80966.0    98855.0       12.2
File Copy 256 bufsize 500 maxblocks          35210.0    51581.0       14.6
File Copy 4096 bufsize 8000 maxblocks       105054.0   107897.0       10.3
File Read 1024 bufsize 2000 maxblocks       196639.0   196276.0       10.0
File Read 256 bufsize 500 maxblocks         140609.0   140402.0       10.0
File Read 4096 bufsize 8000 maxblocks       197578.0   197291.0       10.0
File Write 1024 bufsize 2000 maxblocks      106733.0   137821.0       12.9
File Write 256 bufsize 500 maxblocks         48994.0    84355.0       17.2
File Write 4096 bufsize 8000 maxblocks      130220.0   139374.0       10.7
Pipe-based Context Switching                223573.7   227789.1       10.2
Pipe Throughput                             477471.4   480723.5       10.1
Process Creation                              9119.5     9281.9       10.2
Shell Scripts (16 concurrent)                   69.0       69.0       10.0
System Call Overhead                        409831.4   411749.2       10.0
                                                                 =========
     FINAL SCORE                                                      10.6

Ciao, 
         Paolo

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
