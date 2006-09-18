Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWIRQEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWIRQEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWIRQEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:04:40 -0400
Received: from re01.intra2net.com ([82.165.28.202]:4102 "EHLO
	re01.intra2net.com") by vger.kernel.org with ESMTP id S1751806AbWIRQEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:04:39 -0400
From: "Gerd v. Egidy" <lists@egidy.de>
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: APIC on Asus M2N SLI Deluxe
Date: Mon, 18 Sep 2006 18:04:36 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Thomas Richter <thor@mail.math.tu-berlin.de>
References: <200609141017.k8EAHdL9017691@mersenne.math.TU-Berlin.DE> <200609172121.44566.lists@egidy.de> <200609172203.18666.prakash@punnoor.de>
In-Reply-To: <200609172203.18666.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181804.36428.lists@egidy.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > recently, I tried to upgrade the bios of the ASUS M2N SLI Deluxe
> > > board from release 0202 to 0307. With the 0307 bios, I get a kernel
> > > panic that the APIC cannot be found. Concerning this, I've two
> > > explanations, could possibly confirm someone here this:
> >
> > I can confim this problem.
>
> Does it boot with no_timer_check boot parameter?

no, same bug.

Booting with apic=debug as suggested in the error message doesn't reveal any 
additional details. Maybe I have to compile with some special debug options?

Kind regards,

Gerd
