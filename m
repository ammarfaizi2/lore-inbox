Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRDKMkb>; Wed, 11 Apr 2001 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRDKMkU>; Wed, 11 Apr 2001 08:40:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17676 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132568AbRDKMkK>; Wed, 11 Apr 2001 08:40:10 -0400
Subject: Re: 2.4 kernel problem
To: dash@xdr.com (David Ashley)
Date: Wed, 11 Apr 2001 13:41:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104110530.WAA00945@dave.xdr.com> from "David Ashley" at Apr 10, 2001 10:30:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nJwA-0006Yd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> XFree86 X window updates are slower on 2.4 than 2.2, by a significant amount.
> I've observed this comparing 2.2.18 with 2.4.1 and one of the 2.4.pre kernels.

Quite possible since we haven't really tuned it hard yet. Also there are some
problems with VIA chipsets and 2.4 that directly impact this sort of stuff

