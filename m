Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277397AbRJEOhD>; Fri, 5 Oct 2001 10:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277394AbRJEOgz>; Fri, 5 Oct 2001 10:36:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5894 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277399AbRJEOgq>; Fri, 5 Oct 2001 10:36:46 -0400
Subject: Re: Linux and 760MP
To: vichu@digitalme.com (Trever L. Adams)
Date: Fri, 5 Oct 2001 15:42:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1002286888.1262.1.camel@aurora> from "Trever L. Adams" at Oct 05, 2001 09:01:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pWBH-0006ZB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been reading here about problems with Dual Athlon systems and
> Linux.  I understand some of these are apparently chipset or DMA
> related.
> 
> Can anyone point me to more recent information on newer boards and such
> where I can find out if this is still a problem now or not?

Pick up the 760MP errata document from AMD if you are curious. The major 
problems in the 760MP about DMA are fixed in the production steppings. From
memory the production ones have a couple of IDE errata (performance and
can't enable prefetching) and an APIC one

Alan
