Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVAGQuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVAGQuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVAGQuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:50:11 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26049 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261510AbVAGQuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:50:03 -0500
Subject: Re: Linux 2.6.10-ac5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87r7kxmeiw.fsf@kosh.ultra.csn.tu-chemnitz.de>
References: <1105058480.24187.308.camel@localhost.localdomain>
	 <87r7kxmeiw.fsf@kosh.ultra.csn.tu-chemnitz.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105110243.24896.343.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 15:45:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 15:42, Enrico Scholz wrote:
> alan@lxorguk.ukuu.org.uk (Alan Cox) writes:
> 
> > Forward ported from 2.6.9-ac
> > o	More ATI IDE PCI identifiers			(Enrico Scholza)
>                                                                       ^
>                                                     this is too much...

Fixed

> Please move the SATA device (4379) into the sata_sil.c driver. See
> http://marc.theaimsgroup.com/?l=linux-ide&m=110357606225070&w=2

Talk to Jeff Garzik

