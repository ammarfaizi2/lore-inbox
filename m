Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292829AbSBVHiI>; Fri, 22 Feb 2002 02:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292830AbSBVHh6>; Fri, 22 Feb 2002 02:37:58 -0500
Received: from 1Cust79.tnt6.lax7.da.uu.net ([67.193.244.79]:19701 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S292829AbSBVHhq>; Fri, 22 Feb 2002 02:37:46 -0500
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
To: jamagallon@able.es (J.A. Magallon)
Date: Thu, 21 Feb 2002 23:38:41 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (Lista Linux-Kernel), rwhron@earthlink.net
In-Reply-To: <20020222015003.A1641@werewolf.able.es> from "J.A. Magallon" at Feb 22, 2002 01:50:03 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020222073841.EC00F89C87@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Extras:
[snip]
> - irqrate-A1, intr-seq-file

FWIW, the irqrate-A1 patch from the -slb/-jam series kernels
(2.4.18-rc1-slb2 through 2.4.18-rc2-jam1 for certain) seems to make one of
my computers (a dual 1GHz PIII, Iwill DVD266-R motherboard) hang when I
access the floppy drive. I don't believe this happens on other
(uniprocessor, not SMP) machines I have here, although I'm not certain
about that. This is 100% reproducible.

This bug report is probably rather vague, but I probably won't have time
for anything more detailed or any debugging activities related to this for
several weeks, and I hope this report is better than nothing.

-Barry K. Nathan <barryn@pobox.com>
