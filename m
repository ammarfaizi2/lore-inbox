Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVKBPls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVKBPls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKBPls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:41:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:63718 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965092AbVKBPlr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:41:47 -0500
Message-ID: <5156553.1130946100018.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 2 Nov 2005 16:41:40 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: New (now current development process)
Cc: Linus Torvalds <torvalds@osdl.org>, zippel@linux-m68k.org,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051031163408.41a266f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-295-smp i386 (JVM 1.3.1_13)
Organization: SuSE Linux AG
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org> <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di 01.11.2005 01:34 schrieb Andrew Morton <akpm@osdl.org>:

> It happened somewhere between 2.5.71 and 2.6.8.
>

bloat-o-meter might tell who is to blame. Just run it
with the two vmlinuxes and it will display the differences in symbol
sizes
 
ftp://ftp.firstfloor.org/pub/ak/bloat-o-meter
 
-Andi

