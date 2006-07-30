Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWG3KYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWG3KYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWG3KYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:24:04 -0400
Received: from aun.it.uu.se ([130.238.12.36]:18882 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932229AbWG3KYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:24:03 -0400
Date: Sun, 30 Jul 2006 12:23:32 +0200 (MEST)
Message-Id: <200607301023.k6UANWKj019190@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, mrmacman_g4@mac.com
Subject: Re: Trying to get my shiny new G5 (quad 2.5GHz) to boot under Linux
Cc: benh@kernel.crashing.org, paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2006 22:06:56 -0400, Kyle Moffett wrote:
>I just bought a brand new absolute-bleeding-edge Quad 2.5GHz G5 (it's  
>actually dual-proc dual-core, but that's marketing for you) and I'm  
>trying to find a kernel that will boot the system.  Well actually I'm  
>_trying_ to install Debian but I have yet to even get to mounting the  
>initramfs.  Here's a list of the kernels I've tried:
>
>   Debian-Installer beta2 (I think this is 2.6.15?)
>   Debian 2.6.16-1-powerpc64
>   Debian 2.6.17-1-powerpc64
>   Custom 2.6.18-rc2+git (64821324ca49f24be1a66f2f432108f96a24e596)
...
>If you have gotten Linux to boot on the Quad G5; I'd really  
>appreciate it if you could send me a working .config (or even better,  
>a working vmlinux image).  Thanks for all your help!

You really should try YDL 4.1's kernel. I would be very
surprised if it didn't work.
