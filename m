Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVJRFd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVJRFd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVJRFd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 01:33:56 -0400
Received: from mail.hg.com ([199.79.200.252]:4542 "EHLO mail.hg.com")
	by vger.kernel.org with ESMTP id S932348AbVJRFd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 01:33:56 -0400
From: "rob" <rob@janerob.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, jbarnes@virtuousgeek.org,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Date: Tue, 18 Oct 2005 06:32:41 +0100
Message-Id: <20051018052149.M34048@janerob.com>
In-Reply-To: <4353CA12.8020708@s5r6.in-berlin.de>
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de> <20051015202944.GA10463@plato.virtuousgeek.org> <20051017005515.755decb6.akpm@osdl.org> <4353705D.6060809@s5r6.in-berlin.de> <20051017024219.08662190.akpm@osdl.org> <20051017124711.M44026@janerob.com> <4353CA12.8020708@s5r6.in-berlin.de>
X-Mailer: Open WebMail 2.51 20050228
X-OriginatingIP: 193.220.20.68 (rob)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005 17:58:10 +0200, Stefan Richter wrote
...
> > Toshiba Satellite 5105-s607
> 
> Thanks a lot for the survey. Do they all _need_ the patch, or do 
> some of them need it and the others are just not harmed by the patch?

they all need the patch to modprobe without errors, not all had firewire
devices to test with.

> Does anybody know a DMI_PRODUCT_NAME of a Libretto L1? Something 
> like PAL1060TNMM or PAL1060TNCM?

Might try John Belmonte <john at neggie.net>, he has an L5 and runs a website
for it.

rob.


--
Open WebMail Project (http://openwebmail.org)

