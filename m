Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbTGTRWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 13:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbTGTRWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 13:22:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13048 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267563AbTGTRWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 13:22:19 -0400
Date: Sun, 20 Jul 2003 19:37:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Constantine 'Gus' Fantanas" <fantanas@innocent.com>
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: menuconfig crash
Message-ID: <20030720173713.GA26422@fs.tum.de>
References: <3F18C90B.305@innocent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F18C90B.305@innocent.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 12:28:59AM -0400, Constantine 'Gus' Fantanas wrote:
> To Whom it May Concern:
> 
> I experienced a menuconfig crash and I am following the notication 
> instructions of the error message (pasted below).  At the time of the 
> crash, I was in the sound configuration section and was entering the 
> ALSA configuration subsection. The kernel I was trying to configure was 
> a Mandrake 2.4.21 kernel: linux-2.4.21-0.18mdk.
> 
> Here is the error message:
> 
> -------------BEGINNING OF PASTED MATERIAL------------------------------
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
> Q> scripts/Menuconfig: line 832: MCmenu73: command not found
> 
> Please report this to the maintainer <mec@shout.net>.  You may also
> send a problem report to <linux-kernel@vger.kernel.org>.
> 
> Please indicate the kernel version you are trying to configure and
> which menu you were trying to enter when this error occurred.
> 
> make: *** [menuconfig] Error 1
>...

This sounds like a known bug in at least one version of the Mandrake 
kernel sources.

It doesn't occur in plain 2.4.21, please ask Mandrake for fixed kernel 
sources.

> Regards,
> 
> Gus Fantanas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

