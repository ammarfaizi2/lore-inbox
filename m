Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTEMEtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbTEMEtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:49:16 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:13328 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262850AbTEMEtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:49:15 -0400
Date: Tue, 13 May 2003 07:01:33 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
Message-ID: <20030513050133.GA4720@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <200305122135.53751.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305122135.53751.josh@stack.nl>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jos Hulzink <josh@stack.nl>
Date: Mon, May 12, 2003 at 09:35:53PM +0200
> Hi,
> 
> (kernel: 2.5.69)
> 
> The conclusion of bug 699 is that some / all i386 SMP systems that use MPS 1.4 
> (and higher ? or all MPS versions ?), should boot with the "pci=noacpi" 
> parameter to prevent IRQ problems.
> 
Is this with or without IOAPIC? I got some problems with MPS 1.4, acpi
and the local ioapic on a uniprocessor system, see bugzilla 678. I think
it's a different problem, though.

Jurriaan
-- 
Evayne's smile turned sharply inward, although it remained on her face,
changed in tone and texture. "It loses none of its power," she whispered,
"and all of its romance."
	Michelle West - Hunter's Death
Debian (Unstable) GNU/Linux 2.5.69 4112 bogomips load av: 0.64 0.16 0.05
