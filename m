Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133074AbRECMIA>; Thu, 3 May 2001 08:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135618AbRECMHu>; Thu, 3 May 2001 08:07:50 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:34737 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S133074AbRECMHp>;
	Thu, 3 May 2001 08:07:45 -0400
Date: Thu, 3 May 2001 13:13:13 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.4 parport compile error
Message-ID: <Pine.LNX.4.21.0105031312280.20986-100000@linux.home>
X-mailer: Pine 4.21
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make[3]: Entering directory
`/home/mistral/data/kernels/SX/drivers/parport'
gcc -D__KERNEL__ -I/home/mistral/data/kernels/SX/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-march=i486    -c -o parport_pc.o parport_pc.c
parport_pc.c: In function `parport_pc_find_ports':
parport_pc.c:2618: too many arguments to function
`parport_pc_init_superio'
make[3]: *** [parport_pc.o] Error 1
make[3]: Leaving directory `/home/mistral/data/kernels/SX/drivers/parport'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/mistral/data/kernels/SX/drivers/parport'
make[1]: *** [_subdir_parport] Error 2
make[1]: Leaving directory `/home/mistral/data/kernels/SX/drivers'
make: *** [_dir_drivers] Error 2


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  1:10pm  up 21:06,  6 users,  load average: 10.81, 13.53, 14.58

