Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263889AbTCUTqv>; Fri, 21 Mar 2003 14:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263892AbTCUTpa>; Fri, 21 Mar 2003 14:45:30 -0500
Received: from magic-mail.adaptec.com ([208.236.45.100]:19400 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S263890AbTCUToW>; Fri, 21 Mar 2003 14:44:22 -0500
Date: Fri, 21 Mar 2003 12:54:42 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2
Message-ID: <411800000.1048276482@aslan.btc.adaptec.com>
In-Reply-To: <Pine.LNX.4.50.0303210202080.2133-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303210202080.2133-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Justin i got this booting 2.5.65-mm2, 2.5.65 was fine there is an oops 
> right at the end. Is there anything specific you want?

It would be nice to know the devices that are attached to the controller.
Could you also use the latest driver from here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

Be sure to enable "Decode registers during diagnostics" when configuring
the driver and send me the output you get.

Thanks,
Justin

