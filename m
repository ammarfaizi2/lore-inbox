Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132677AbQLNTGj>; Thu, 14 Dec 2000 14:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbQLNTGY>; Thu, 14 Dec 2000 14:06:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7172 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132677AbQLNTGL>; Thu, 14 Dec 2000 14:06:11 -0500
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 14 Dec 2000 18:38:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <200012141802.eBEI2is52509@aslan.scsiguy.com> from "Justin T. Gibbs" at Dec 14, 2000 11:02:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146dGc-00009J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only reason "namespace restoration" is an issue at all is due to the
> poor design of hosts.c in 2.2.X kernels.  A better solution would be to
> bring in the build hooks from 2.4 so modules and compiled in drivers are

I agree entirely. 2.2.18 has the build hooks in. Switching the hosts file to
use them in 2.2.19 is an option if someone wants to do it.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
