Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUHJMgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUHJMgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUHJMfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:35:55 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:61910 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264665AbUHJMfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:35:39 -0400
Date: Tue, 10 Aug 2004 14:34:39 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101234.i7ACYdwP013901@burner.fokus.fraunhofer.de>
To: mpm@selenic.com, schilling@fokus.fraunhofer.de
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-kernel@vger.kernel.org,
       vonbrand@inf.utfsm.cl
Subject: Re: Linux Kernel bug report (includes fix)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Matt Mackall <mpm@selenic.com>

>> You should know that GLIBc is unrelated to the Linux kernel interfaces we are> talking about. Start using serious arguments please.

>If you had any inkling, you'd have caught on by now that using kernel
>headers in userspace programs has been deprecated for about six years.

Well, everybody has the right to make mistakes and trying to force people
not to use the official header is a big mistake.


If Linux was a complete OS and not only a Kernel and if it was always released 
with a full set of /usr/include files, libc, utilities,.... this could work.
But even then only if somebody would test the consistence of everything.

Releasing the kernel separately requires the kernel distribution to contain
a usable set of include files that match the interfaces inside the kernel.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
