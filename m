Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbTHaRfA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHaRfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:35:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32483 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262511AbTHaRe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:34:56 -0400
Date: Sun, 31 Aug 2003 19:34:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ETO <by_eto@yahoo.com>
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: make: *** [menuconfig] Error 1
Message-ID: <20030831173448.GV7038@fs.tum.de>
References: <20030831152103.65679.qmail@web40505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831152103.65679.qmail@web40505.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 08:21:03AM -0700, ETO wrote:
> Linux Kernel v2.4.22-1mdkcustom Configuration
>  
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
>  Q> scripts/Menuconfig: line 832: MCmenu76: command not found
> 
> Please report this to the maintainer <mec@shout.net>.  You may also
> send a problem report to <linux-kernel@vger.kernel.org>.
> 
> Please indicate the kernel version you are trying to configure and
> which menu you were trying to enter when this error occurred.
> 
> make: *** [menuconfig] Error 1

This is a known bug in the modifications Mandrake made to it's kernel 
sources.

Most likely there's already a fixed Mandrake pacakge available, if not
please contact Mandrake.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

