Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSAIQzq>; Wed, 9 Jan 2002 11:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287860AbSAIQz1>; Wed, 9 Jan 2002 11:55:27 -0500
Received: from web14912.mail.yahoo.com ([216.136.225.248]:19474 "HELO
	web14912.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287786AbSAIQzT>; Wed, 9 Jan 2002 11:55:19 -0500
Message-ID: <20020109165518.98129.qmail@web14912.mail.yahoo.com>
Date: Wed, 9 Jan 2002 11:55:18 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: About Loop Device
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020109112617.5394A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply. But when I try to use the
command "mount -o loop /dev/fd0 /floppy", the mount
returns an error saying "mount: you must specify the
filesystem type". What is wrong? Thanks.

Michael


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Wed, 9 Jan 2002, Michael Zhu wrote:
> [SNIPPED...]
> 
> > connection between my own loop device with the
> floppy
> > disk? I mean how I can connect the loop device
> with
> > the floppy disk to hook the READ/WRITE operations
> to
> > the floppy disk.
> > 
> > Michael
> > 
> 
> mount -o loop /dev/fd0 /mnt
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine
> (797.90 BogoMips).
> 
>     I was going to compile a list of innovations
> that could be
>     attributed to Microsoft. Once I realized that
> Ctrl-Alt-Del
>     was handled in the BIOS, I found that there
> aren't any.
> 
> 


______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
