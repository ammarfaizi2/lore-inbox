Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTIADMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 23:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTIADMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 23:12:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38353 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262056AbTIADMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 23:12:13 -0400
Date: Mon, 1 Sep 2003 05:12:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Daniel Lyddy <sprocket@PATH.Berkeley.EDU>
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: Q> scripts/Menuconfig: line 832: MCmenu78: command not found
Message-ID: <20030901031209.GD7038@fs.tum.de>
References: <200308311838.25279.sprocket@path.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308311838.25279.sprocket@path.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 06:38:25PM -0700, Daniel Lyddy wrote:

> I got this error while trying to use menuconfig to set up Kernel 2.4.22-3mdk 
> sources for compilation.  I was trying to enter the "alsa" part of the 
> "sound" section.
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
>  Q> scripts/Menuconfig: line 832: MCmenu78: command not found
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

Most likely there's already a fixed Mandrake package available, if not
please contact Mandrake.



> Dan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

