Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbTGWKXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbTGWKXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:23:05 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:15606 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S265955AbTGWKXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:23:00 -0400
Subject: Re: Promise SATA driver GPL'd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10307221852030.8687-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10307221852030.8687-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058956331.5520.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 11:32:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 02:59, Andre Hedrick wrote:
> I have already cut all ties with Promise so here is the deal.
> I no longer have to count the number of fingers on my hand between hand
> shakes.  IE no extras and not shortages.

Thats ok - now they are doing GPL drivers themselves they don't need
you any more.

Promise did a SCSI CAM driver because their hardware can queue commands
without TCQ - which drivers/ide can't cope with. Otherwise I'd just have
used the same type of changes the FreeBSD people did for 2037x.

Its also interesting because it has a hardware XOR engine.

