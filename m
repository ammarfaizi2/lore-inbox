Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266148AbUFPEME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUFPEME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUFPEMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:12:02 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:39695 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S266148AbUFPEK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:10:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <eric@cisu.net>, "Christoph Hellwig" <hch@lst.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: more files with licenses that aren't GPL-compatible
Date: Tue, 15 Jun 2004 21:11:00 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEFGMKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200406151938.02613.eric@cisu.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 15 Jun 2004 20:48:38 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 15 Jun 2004 20:48:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	Permission is hereby granted for the distribution of this firmware
> > 	image as part of a Linux or other Open Source operating
> >   system kernel
> > 	in text or binary form as required.

	They can't grant that permission. Every single person who had contributed
to the Linux kernel would have to agree. The GPL prohibits including
software that isn't itself GPL'd from being combined with GPL'd software.
The issue is not permission to distribute this driver, the issue is
permission to distribute the *kernel*. The kernel's license prohibits
distrubiting it in combination with works that have licenses more
restrictive than the GPL.

> > 	This firmware may not be modified and may only be used with
> > 	Keyspan hardware.

	That's more restrictive than the GPL. So if you link this with a GPL'd
work, the entirety must be distributed under the GPL, which you can't do
since you can't authorize the unrestricted use of the firmware

> > which makes the kernel as whole unredistributable.  A similar license

	Bingo.

> Unredistributable? Am I mistaken? It says permission is given to
> redistribute
> this piece as part of the linux kernel. You just can't modify it.
> Although it
> is unquestionably not a very permissive license, it's inclusion is not
> detrimental to the kernel.

	He didn't say this made the firmware unredistributable, he said it made the
*kernel* unredistributable. Since you can't GPL the firmware, the kernel as
a whole is not GPL. You cannot distribute a non-GPL Linux kernel because the
GPL prohibits it as the GPL applies to everything else in the kernel.

> Please correct me if I am wrong.

	You *definitely* are wrong. The entirety of the GPL would be negated if you
were correct.

	DS


