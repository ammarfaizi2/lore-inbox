Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRIHNdz>; Sat, 8 Sep 2001 09:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbRIHNdq>; Sat, 8 Sep 2001 09:33:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62733 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269489AbRIHNdi>; Sat, 8 Sep 2001 09:33:38 -0400
Subject: Re: nfs is stupid ("getfh failed")
To: kullstam@ne.mediaone.net (Johan Kullstam)
Date: Sat, 8 Sep 2001 14:38:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2ae06a6t7.fsf@euler.axel.nom> from "Johan Kullstam" at Sep 07, 2001 08:02:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fiJ6-0003sK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Michael Rothwell" <rothwell@holly-springs.nc.us> writes:
> 
> > Just wondering if there's been any talk, plans, etc. of an alternative for
> > NFS.
> 
> there's coda.

You probably want inter-mezzo rather than coda for that kind of file
service. Coda is a research project, inter-mezzo is kind of "distilled coda
and afs", making it a real fs.  http://www.inter-mezzo.org

