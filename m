Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270469AbRHSOIT>; Sun, 19 Aug 2001 10:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270464AbRHSOH7>; Sun, 19 Aug 2001 10:07:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17934 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270472AbRHSOHy>; Sun, 19 Aug 2001 10:07:54 -0400
Subject: Re: gcc-3.0 with 2.2.x ?
To: haiquy@yahoo.com (=?iso-8859-1?q?Steve=20Kieu?=)
Date: Sun, 19 Aug 2001 15:10:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <no.id> from "=?iso-8859-1?q?Steve=20Kieu?=" at Aug 19, 2001 04:09:07 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YTHy-0004Dn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can use gcc-3.0 to compile 2.4.8-ac7 but can not do
> that with 2.2.19

> so I would like to know if there is any patches to
> 2.2.19 to make it friendlier with gcc-3.0. In the mean
> time I am going to see sched.c and sched.h and try to
> make it work :-)

I've got no plans to care about 2.2 and gcc 3.0. Trying to deal with all
the fun things gcc 3.0 does (quite legally too the ones I looked at) is
hard. The amount of work required to fix it is large and given 2.2 is
there for maximum stability also pointless, since its an untrusted compile
combination.

Alan
