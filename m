Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287907AbSAMBuN>; Sat, 12 Jan 2002 20:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287933AbSAMBuD>; Sat, 12 Jan 2002 20:50:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30468 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287907AbSAMBtx>; Sat, 12 Jan 2002 20:49:53 -0500
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
To: reid.hekman@ndsu.nodak.edu (Reid Hekman)
Date: Sun, 13 Jan 2002 02:01:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1010886332.4650.0.camel@zeus> from "Reid Hekman" at Jan 12, 2002 07:45:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZxl-0003lQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.2 does not support VIA SMP, its probably not a good kernel to choose for
> > the buggy VIA chipsets either. 
> 
> So ServerWorks (re: his Asus CUR-DLS) is right out as well?

Serverworks I don't know. I've got reports of serverworks SMP working perfectly
well in the 2.2 tree so I don't know what the full story is there. 
