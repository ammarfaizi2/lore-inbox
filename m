Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283182AbRLDP2R>; Tue, 4 Dec 2001 10:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283080AbRLDP07>; Tue, 4 Dec 2001 10:26:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283191AbRLDP0S>; Tue, 4 Dec 2001 10:26:18 -0500
Subject: Re: clock timer configuration lost on a ServerWorks Chipset
To: knuffie@xs4all.nl (Seth Mos)
Date: Tue, 4 Dec 2001 15:35:13 +0000 (GMT)
Cc: linux-poweredge@dell.com, linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011204145737.034402c8@pop.xs4all.nl> from "Seth Mos" at Dec 04, 2001 03:31:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BHbF-0002P2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nov 28 14:03:51 coltex-2 kernel: probable hardware bug: clock timer 
> configuration lost - probably a VIA686a motherboard.
> Nov 28 14:03:51 coltex-2 kernel: probable hardware bug: restoring chip 
> configuration.

Ignore them. They can be triggered by other things. The workaround they
do is harmless however.
