Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312311AbSCUAY0>; Wed, 20 Mar 2002 19:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312319AbSCUAYR>; Wed, 20 Mar 2002 19:24:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312311AbSCUAYE>; Wed, 20 Mar 2002 19:24:04 -0500
Subject: Re: [PATCH] 2.4: BUG_ON (2/2)
To: rml@tech9.net (Robert Love)
Date: Thu, 21 Mar 2002 00:40:08 +0000 (GMT)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1016669776.15474.267.camel@phantasy> from "Robert Love" at Mar 20, 2002 07:16:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nqci-0003ra-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch, which requires the previous BUG_ON part 1 patch, changes a
> few uses of BUG -> BUG_ON in fast paths in the kernel.
> 
> Patch is against 2.4.19-pre4.  Marcelo, please apply.

Can we get Andrew's "oh look my kernel is 100Kb smaller" changes in first,
there are some clashes here and I think the 100K one is more important
personally 8)
