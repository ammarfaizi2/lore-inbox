Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLNSX1>; Thu, 14 Dec 2000 13:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNSXR>; Thu, 14 Dec 2000 13:23:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26884 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129429AbQLNSXK>; Thu, 14 Dec 2000 13:23:10 -0500
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 14 Dec 2000 17:54:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <200012141359.eBEDxFs46530@aslan.scsiguy.com> from "Justin T. Gibbs" at Dec 14, 2000 06:59:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146cal-0000JD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I figured as much.  I will test for the #define, stash it in a #define
> unique within my namespace, and #define it back in hosts.c should my
> local define exist.

If that driver hits a tree I maintain be aware that the first thing I will do
is rip that out and rename the 'current' variables in it 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
