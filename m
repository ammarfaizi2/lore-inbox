Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTBQRMV>; Mon, 17 Feb 2003 12:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTBQRMV>; Mon, 17 Feb 2003 12:12:21 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39676 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267219AbTBQRMU>; Mon, 17 Feb 2003 12:12:20 -0500
Date: Mon, 17 Feb 2003 18:22:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.61-ac1: Kernel .config support is incomplete
Message-ID: <20030217172214.GN20159@fs.tum.de>
References: <200302171556.h1HFujt30305@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302171556.h1HFujt30305@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

it seems at least one file needed for Kernel .config support got lost:

<--  snip  -->

...
make[1]: *** No rule to make target `kernel/configs.c', needed by `kernel/configs.o'.  Stop.
make: *** [kernel] Error 2

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

