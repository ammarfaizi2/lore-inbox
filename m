Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbRGSPBT>; Thu, 19 Jul 2001 11:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbRGSPA7>; Thu, 19 Jul 2001 11:00:59 -0400
Received: from [62.58.73.254] ([62.58.73.254]:61169 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S267582AbRGSPAr>; Thu, 19 Jul 2001 11:00:47 -0400
Date: Thu, 19 Jul 2001 16:51:48 +0200
From: Ryan Sweet <rsweet@atos-group.nl>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 and netboot
In-Reply-To: <20010719082650.A26980@animx.eu.org>
Message-ID: <Pine.SGI.4.10.10107191618070.3370909-100000@iapp-0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 19 Jul 2001, Wakko Warner wrote:

> I'm using a kernel that is dd'd to a floppy to net boot linux on random
> machines.  I noticed that 2.4.6 won't get it's IP from the server (it won't
> even attempt it).  2.4.4 works
> 
> If any more info is needed, just ask.

It sounds as though you left out CONFIG_IP_PNP in the kernel
configuration.  netboot works fine under 2.4.6 for me....


-- 
Ryan Sweet <ryan.sweet@atosorigin.com>
Atos Origin Engineering Services
http://www.aoes.nl

