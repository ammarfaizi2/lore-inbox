Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRADVNf>; Thu, 4 Jan 2001 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRADVNP>; Thu, 4 Jan 2001 16:13:15 -0500
Received: from [202.52.231.194] ([202.52.231.194]:12404 "EHLO healthnet.org.np")
	by vger.kernel.org with ESMTP id <S129655AbRADVNE>;
	Thu, 4 Jan 2001 16:13:04 -0500
From: mpradhan@healthnet.org.np
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Date: Fri, 5 Jan 2001 03:21:02 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Compilation error in Red Hat 6.2
CC: linux-kernel@vger.kernel.org
Message-ID: <3A553D9E.9293.2E81A9@localhost>
In-Reply-To: <3A54F8BD.14576.3D66AD@localhost>
In-Reply-To: <Pine.LNX.4.31.0101041404550.27543-100000@asdf.capslock.lan>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mike A. Harri,

Thank you for your answer.
Kindly let me know in which part comes the IDE, ext2 and ELF after 
running the command make menuconfig.

With regards,

Sincerely yours,

Mohan Raj Pradhan
HealthNet Nepal
Date sent:      	Thu, 4 Jan 2001 14:05:52 -0500 (EST)
From:           	"Mike A. Harris" <mharris@opensourceadvocate.org>
To:             	<mpradhan@healthnet.org.np>
Copies to:      	<linux-kernel@vger.kernel.org>
Subject:        	Re: Compilation error in Red Hat 6.2

> On Thu, 4 Jan 2001 mpradhan@healthnet.org.np wrote:
> 
> >Date: Thu, 4 Jan 2001 22:27:09 +0530
> >From: mpradhan@healthnet.org.np
> >To: linux-kernel@vger.kernel.org
> >Content-Type: text/plain; charset=US-ASCII
> >Subject: Compilation error in Red Hat 6.2
> >
> >Dear users,
> >
> >
> >I am getting one error while compiling kernal in Red Hat 6.2:
> >VFS: cannot open root device 08:01 > Kernel panic: VFS:
> >unable to mount root fs on 08:01 >
> > I have used make bzImage to make the
> >new image after make dep; > make clean.
> 
> Make sure you have compiled into your kernel (not modules) IDE,
> ext2, and ELF.  If you're using SCSI, substitute it with IDE
> above.
> 
> 
> ----------------------------------------------------------------------
>     Mike A. Harris  -  Linux advocate  -  Free Software advocate
>           This message is copyright 2000, all rights reserved.
>   Views expressed are my own, not necessarily shared by my employer.
> ----------------------------------------------------------------------
> 
> Want to run Microsoft Windows software in Linux?  You can!  VMware
> allows you to install and run other operating systems inside a window
> in X windows. You can install Windows 95/98/NT/2000, FreeBSD, Solaris,
> and many more. 3D Games do not work yet, but virtually all office and
> productivity software runs excellent.           http://www.vmware.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
