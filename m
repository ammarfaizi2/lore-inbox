Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWIQTVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWIQTVu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 15:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWIQTVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 15:21:50 -0400
Received: from re01.intra2net.com ([82.165.28.202]:39186 "EHLO
	re01.intra2net.com") by vger.kernel.org with ESMTP id S932369AbWIQTVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 15:21:50 -0400
From: "Gerd v. Egidy" <lists@egidy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: APIC on Asus M2N SLI Deluxe
Date: Sun, 17 Sep 2006 21:21:44 +0200
User-Agent: KMail/1.9.4
References: <200609141017.k8EAHdL9017691@mersenne.math.TU-Berlin.DE>
In-Reply-To: <200609141017.k8EAHdL9017691@mersenne.math.TU-Berlin.DE>
Cc: Thomas Richter <thor@mail.math.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609172121.44566.lists@egidy.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> recently, I tried to upgrade the bios of the ASUS M2N SLI Deluxe
> board from release 0202 to 0307. With the 0307 bios, I get a kernel
> panic that the APIC cannot be found. Concerning this, I've two
> explanations, could possibly confirm someone here this:

I can confim this problem.

I think Asus screwed up the bios...

> It's not a major problem for me right now, the 0202 bios works like
> a charm with the 2.6.17.8 kernel. I'm just curious.

I need Wake-On-LAN and that doesn't work with 0202 and is fixed with 0307. I 
boot the system with the noapic option.

Kind regards,

Gerd
