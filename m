Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLKWXN>; Mon, 11 Dec 2000 17:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131039AbQLKWXD>; Mon, 11 Dec 2000 17:23:03 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:9992 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129383AbQLKWWy>; Mon, 11 Dec 2000 17:22:54 -0500
Message-Id: <200012112152.eBBLqNs06411@aslan.scsiguy.com>
To: Michael@Meding.net
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx version status for 2.4.0test ? 
In-Reply-To: Your message of "Mon, 11 Dec 2000 23:40:32 +0100."
             <00121123403208.00322@Hal> 
Date: Mon, 11 Dec 2000 14:52:23 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all,
>
>am I right that the aic7xx version in latest test is 5.2.1 ? Is there a 
>reason why this is not up to date to Doug Ledfords 5.1.31 ?

My hope is that the Adaptec sponsored driver will eventually
become the driver embedded in 2.4.X kernels.  This driver is
currently in Alpha (Beta to be released later today) and can
be found here:

http://people.FreeBSD.org/~gibbs/linux/

I know the site hosting the driver is a little, well, ironic,
for a Linux driver, but there is too much red tape involved
to distribute the driver from Adaptec's own site while it is
still evolving, and FreeBSD.org has excellent connectivity.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
