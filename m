Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSECNv4>; Fri, 3 May 2002 09:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSECNvz>; Fri, 3 May 2002 09:51:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17161 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313120AbSECNvy>; Fri, 3 May 2002 09:51:54 -0400
Subject: Re: Linux 2.4 as a router, when is it appropriate?
To: russ@elegant-software.com (Russell Leighton)
Date: Fri, 3 May 2002 15:10:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CD28FB8.40204@elegant-software.com> from "Russell Leighton" at May 03, 2002 09:25:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173dlx-0006Pc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have heard that performance wise, if you have a fast CPU,
> much memory and good NICs that Linux can be as good
> all but the high end routers. Are there important missing
> features or realiability issues that make using Linux not
> suitable for "enterprise" use?

CPU and RAM isnt that important. Your normal limit is the PCI bus bandwidth.
At gigabit speeds that becomes a bottleneck, followed by RAM bandwidth.
