Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265379AbSJRWoo>; Fri, 18 Oct 2002 18:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265383AbSJRWoo>; Fri, 18 Oct 2002 18:44:44 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:31916 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265379AbSJRWon>; Fri, 18 Oct 2002 18:44:43 -0400
Message-ID: <20021018225039.18607.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 19 Oct 2002 06:50:39 +0800
Subject: [BENCHMARK] Unixbench 2.5.43 vs 2.4.19
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithoh                                    3664143.2  3631331.8       99.1
C Compiler Throughput                          469.7      460.0       97.9
Dc: sqrt(2) to 99 decimal places             42687.3    33261.3       77.9
Double-Precision Whetstone                     417.4      434.6      104.1
Execl Throughput                               975.8      755.3       77.4
File Copy 1024 bufsize 2000 maxblocks        80966.0    88047.0      108.7
File Copy 256 bufsize 500 maxblocks          35210.0    40467.0      114.9
File Copy 4096 bufsize 8000 maxblocks       105054.0   114034.0      108.5
File Read 1024 bufsize 2000 maxblocks       196639.0   195062.0       99.2
File Read 256 bufsize 500 maxblocks         140609.0   127144.0       90.4
File Read 4096 bufsize 8000 maxblocks       197578.0   196118.0       99.3
File Write 1024 bufsize 2000 maxblocks      106733.0   127375.0      119.3
File Write 256 bufsize 500 maxblocks         48994.0    65799.0      134.3
File Write 4096 bufsize 8000 maxblocks      130220.0   162483.0      124.8
Pipe-based Context Switching                223573.7   186024.4       83.2
Process Creation                              9119.5     5835.0       64.0
Shell Scripts (16 concurrent)                   69.0       89.0      129.0
System Call Overhead                        409831.4   419304.8      102.3
                                                                 =========
     FINAL SCORE                                                     100.2

2.5.43 Process Creation is vey very very slow, does anyone know why ?

Ciao,
        Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
