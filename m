Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbRGLOCa>; Thu, 12 Jul 2001 10:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264663AbRGLOCU>; Thu, 12 Jul 2001 10:02:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31121 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264173AbRGLOCJ>;
	Thu, 12 Jul 2001 10:02:09 -0400
Message-ID: <3B4DADDE.EB66940E@mandrakesoft.com>
Date: Thu, 12 Jul 2001 10:02:06 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Thomson <MarkTT@excite.com>
Cc: markhe@nextd.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1062!
In-Reply-To: <13568034.994942508879.JavaMail.imail@slippery>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Thomson wrote:
> 
> Hi,
> 
> I have a Motorola SM56 PCI modem, and I got the following error when doing
> 'insmod sm56'.
> The sm56 module used to work for all 2.4 kernels prior to kernel 2.4.6. (It
> can be found at
> http://e-www.motorola.com/products/softmodem/support/software.html#linux)
> 
> Using /lib/modules/2.4.6/kernel/drivers/char/sm56.o
> kernel BUG at slab.c:1062!
[...]
> Modules Loaded         NVdriver parport_pc parport autofs4 dmfe ide-scsi
> scsi_mod ide-cd cdrom


You are using closed source kernel modules.  Please report bugs for
closed source modules to your vendor, not here.

	Jeff


-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
