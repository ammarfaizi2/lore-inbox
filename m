Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLMC3K>; Tue, 12 Dec 2000 21:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLMC3A>; Tue, 12 Dec 2000 21:29:00 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:52996 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S129226AbQLMC2s>; Tue, 12 Dec 2000 21:28:48 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200012130128.TAA01479@isunix.it.ilstu.edu>
Subject: Re: National Semiconductor DP83815 ethernet driver?
To: torrey.hoffman@myrio.com (Torrey Hoffman)
Date: Tue, 12 Dec 2000 19:28:34 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, adam@yggdrasil.com ('adam@yggdrasil.com')
In-Reply-To: <4461B4112BDB2A4FB5635DE19958743202239C@mail0.myrio.com> from "Torrey Hoffman" at Dec 12, 2000 04:42:56 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >From searching Google, I know some sort of driver exists. In July, Adam J.
> Richter (adam@yggdrasil.com) posted a 2.2.16 driver he obtained from Dave
> Gotwisner at Wyse Technologies. And Tim Hockin mentioned that he was using
> an NSC driver, but had made some minor modifications.

We're still using a heavily hacked version of the NSC driver on 2.2.x.
When we do 2.4.x, I'll examine the other driver more closely.  I can send
you my hacks on the NSC version, if you need.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
