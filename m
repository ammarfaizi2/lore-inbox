Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTLICeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 21:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTLICeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 21:34:19 -0500
Received: from mhub-c5.tc.umn.edu ([160.94.128.35]:18165 "EHLO
	mhub-c5.tc.umn.edu") by vger.kernel.org with ESMTP id S262522AbTLICeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 21:34:18 -0500
Subject: Re: Menuconfig problem
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Aurelian Pop <aurelian.pop@ondems.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001b01c3bdd6$ed8a2310$1b32e682@dmi.tut.fi>
References: <001b01c3bdd6$ed8a2310$1b32e682@dmi.tut.fi>
Content-Type: text/plain
Message-Id: <1070937247.24407.3.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 20:34:07 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 16:02, Aurelian Pop wrote:
>
> I was trying to recomile my kernel and when configuring it I got the next
> message:
> 
> Quote:
> ********
> 
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
> 
> 
> ********
> End quote.
> 
> 
> Therefore, I'm reporting you that the kernel version is: linux-2.4.22-10mdk

This is an issue with Mandrake's ALSA integration in some older Mandrake
kernels. Try upgrading to the latest Mandrake kernel.

Matt

