Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S262475AbUKDWEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbUKDWEz (ORCPT <rfc822;akpm@zip.com.au>);
	Thu, 4 Nov 2004 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUKDWCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:02:40 -0500
Received: from sd291.sivit.org ([194.146.225.122]:10886 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262454AbUKDV5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:57:44 -0500
Date: Thu, 4 Nov 2004 22:58:05 +0100
From: Stelian Pop <stelian@popies.net>
To: Roland Mas <roland.mas@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: meye bug? (was: meye driver update)
Message-ID: <20041104215805.GB3996@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Roland Mas <roland.mas@free.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041104111231.GF3472@crusoe.alcove-fr> <87zn1xjoqo.fsf@mirexpress.internal.placard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zn1xjoqo.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 10:19:59PM +0100, Roland Mas wrote:

>   I'd like to take the opportunity to report a bug with meye.  I've
> ran various 2.6.* kernels on this recently acquired laptop, including
> 2.6.10-rc1 with your patches, all that with a Debian system on it
> (Sarge/testing).  I figured the simplest way to test the meye driver,
> and to grab a shot from it, would be to use "motioneye -j foo.jpeg".
> Everytime I run that, though, the motioneye process gets stuck into an
> apparently endless loop.  top shows it alternatively at states R and
> D, I can't kill it (even -9), and the kernel repeatedly complains
> "meye: need to reset HIC!".  Repeatedly, as in about twice a second
> until reboot.  Oh, and no picture ever comes out, either :-)
[...]
> sonypi: detected type1 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
                                                              ^^^^^^^^^^^^

:)

Stelian.
-- 
Stelian Pop <stelian@popies.net>
