Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRALV6n>; Fri, 12 Jan 2001 16:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbRALV6Y>; Fri, 12 Jan 2001 16:58:24 -0500
Received: from mail.zmailer.org ([194.252.70.162]:31240 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129562AbRALV6Q>;
	Fri, 12 Jan 2001 16:58:16 -0500
Date: Fri, 12 Jan 2001 23:58:07 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: Donald Becker <becker@scyld.com>, vortex@scyld.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: Strange network problems with 2.4.0 and 3c59x.o
Message-ID: <20010112235807.M25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.10.10101020019010.8957-100000@vaio.greennet> <3A51D40F.48B9ADB9@home.net> <3A5F791F.BCC236C1@Home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A5F791F.BCC236C1@Home.net>; from Shawn.Starr@Home.net on Fri, Jan 12, 2001 at 04:37:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 04:37:35PM -0500, Shawn Starr wrote:
> Here's something strange that i've been noticing with 2.4.0. Some
> websites I am unable to access now. For example:

  This is FAQish thing.  DON'T USE TCP_ECN unless you want trouble!

    # echo 0 > /proc/sys/net/ipv4/tcp_ecn

> Shawn S.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
