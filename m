Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269833AbRHIPMQ>; Thu, 9 Aug 2001 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269838AbRHIPMG>; Thu, 9 Aug 2001 11:12:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1797 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269833AbRHIPLt>; Thu, 9 Aug 2001 11:11:49 -0400
Subject: Re: Swapping for diskless nodes
To: dws@dirksteinberg.de (Dirk W. Steinberg)
Date: Thu, 9 Aug 2001 16:14:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <no.id> from "Dirk W. Steinberg" at Aug 09, 2001 03:17:58 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UrVb-0007SG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Alan,
> 
> what you say sound a lot like a hacker solution ("check that it uses the
> right GFP_ levels"). I think it's about time that this deficit of linux

Nope. I'm simply advising people to check that nbd is correctly written.

> as compared to SunOS or *BSD should be removed. Network paging should be
> supported as a standard feature of a stock kernel compile.

There I'd agree entirely.
