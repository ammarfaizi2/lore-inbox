Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbSJESY1>; Sat, 5 Oct 2002 14:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262439AbSJESY1>; Sat, 5 Oct 2002 14:24:27 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:33505 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262434AbSJESY0>; Sat, 5 Oct 2002 14:24:26 -0400
Message-ID: <20021005182850.31930.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <conman@kolivas.net>, linux-kernel@vger.kernel.org
Cc: <akpm@digeo.com>, <rmaureira@alumno.inacap.cl>, <rcastro@ime.usp.br>
Date: Sun, 06 Oct 2002 02:28:50 +0800
Subject: Re: [BENCHMARK] contest 0.50 results to date
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here are my results:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              128.8   97      0       0       1.01
2.4.19-0.24pre4 [3]     127.4   98      0       0       0.99
2.5.40 [3]              134.4   96      0       0       1.05
2.5.40-nopree [3]       133.7   96      0       0       1.04

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              194.1   60      134     40      1.52
2.4.19-0.24pre4 [3]     193.2   60      133     40      1.51
2.5.40 [3]              184.5   70      53      31      1.44
2.5.40-nopree [3]       286.4   45      163     55      2.24

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              461.0   28      46      8       3.60
2.4.19-0.24pre4 [3]     235.4   55      26      10      1.84
2.5.40 [3]              293.6   45      25      8       2.29
2.5.40-nopree [3]       269.4   50      20      7       2.10

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              161.1   80      38      2       1.26
2.4.19-0.24pre4 [3]     181.2   76      253     19      1.41
2.5.40 [3]              163.0   80      34      2       1.27
2.5.40-nopree [3]       161.7   80      34      2       1.26

Comments ?

Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
