Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUC3Suj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUC3Suj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:50:39 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:37380 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id S263828AbUC3Sud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:50:33 -0500
Date: Tue, 30 Mar 2004 20:49:15 +0200 (CEST)
From: Sven Hartge <hartge@ds9.gnuu.de>
To: Tom Rini <trini@kernel.crashing.org>
cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
In-Reply-To: <20040329151515.GD2895@smtp.west.cox.net>
Message-ID: <c4cf82nnq0@ds9.argh.org>
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee>
 <20040326185103.GB20819@smtp.west.cox.net> <E1B7EHF-0004Jm-DY@ds9.argh.org>
 <20040329151515.GD2895@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um 08:15 Uhr am 29.03.04 schrieb Tom Rini:

> Ok.  Can both of you try the following patch on top of the version which
> fails?

2.6.4 and earlier are unpatchable, because they differ to much from 2.6.5.
Someone with a better connection than a tiny ISDN line should check the
ppc32-changes between 2.6.2-rc2 and 2.6.4, because 2.6.2-rc2 was the last
kernel I tried before 2.6.4 and 2.6.2-rc2 did at least boot.

2.6.5-rc2 and -rc3 don't behave any better after patching than before.

S°
