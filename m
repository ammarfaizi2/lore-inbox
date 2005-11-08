Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVKHWWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVKHWWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKHWWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:22:55 -0500
Received: from mtao02.charter.net ([209.225.8.187]:29664 "EHLO
	mtao02.charter.net") by vger.kernel.org with ESMTP id S965149AbVKHWWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:22:54 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17265.9265.460229.523397@smtp.charter.net>
Date: Tue, 8 Nov 2005 17:18:25 -0500
From: "John Stoffel" <john@stoffel.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3D video card recommendations
In-Reply-To: <20051108220853.GA26615@merlin.emma.line.org>
References: <1131112605.14381.34.camel@localhost.localdomain>
	<1131349343.2858.11.camel@laptopd505.fenrus.org>
	<1131367371.14381.91.camel@localhost.localdomain>
	<20051107152009.GA20807@shuttle.vanvergehaald.nl>
	<1131377496.2858.21.camel@laptopd505.fenrus.org>
	<1131384906.14381.108.camel@localhost.localdomain>
	<20051108220853.GA26615@merlin.emma.line.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthias" == Matthias Andree <matthias.andree@gmx.de> writes:

Matthias> I'd rather not count the drivers that have dropped out of
Matthias> open source operating systems due to bit rot. If there is no
Matthias> maintainer, the hardware will become useless sooner or
Matthias> later. With Linux's rapidly changing "moving target" 2.6.X
Matthias> I'd call it sooner rather than later.

Matthias> OSS drivers are good iff there is a maintainer - IOW: to the
Matthias> user, the maintainer makes the difference, not the driver
Matthias> being open source.

No, a publically available spec for the hardware is what makes the
difference.  Those drivers which are reverse engineered, or which have
only partially open specs are the ones which bit-rot the fastest.  

For example, I've got a webcam which I've never been able to make work
properly due to the PWC driver and the lack of documentation from
Philips on the chipset.  Even with heroic efforts by others, it's just
hard to do.  

But if we have docs, we could support this camera until the end of
time, as long as people were interested in supporting it.  

John
