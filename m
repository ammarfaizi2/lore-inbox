Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbTDBEMm>; Tue, 1 Apr 2003 23:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbTDBEMm>; Tue, 1 Apr 2003 23:12:42 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:54268
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261508AbTDBEMl>; Tue, 1 Apr 2003 23:12:41 -0500
Date: Tue, 1 Apr 2003 23:19:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Joe Korty <joe.korty@ccur.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function needs mb()
In-Reply-To: <Pine.LNX.4.50.0304012313000.8773-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0304012318450.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010305510.8773-100000@montezuma.mastecende.com>
 <20030401220004.GB30989@tsunami.ccur.com>
 <Pine.LNX.4.50.0304011919300.8773-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0304012313000.8773-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some vmstat too...

 procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs  us sy id
 1 129  3  25416   3348   7504  96220    0   76  3356  1252  414   760 42 14 44
17 115  3  25416   2368   7592  97004   32  156  2080  7420  453   690 21 54 26
 2 128  2  25416   3484   7780  96768    0   16  1108   988  296   572 39 41 20
 2 128  3  25416   3980   8284  93964    0    0   524   504  443   873 43 21 36
 2 127  2  25416   3488   8816  91616   32   44   500  1944  468   752 35 44 21
 4 127  2  25568   3956   9208  90544    0  308   340  1420  374   457 14 79  7


-- 
function.linuxpower.ca
