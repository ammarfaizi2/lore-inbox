Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWHXNBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWHXNBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWHXNBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:01:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10217 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751303AbWHXNBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:01:18 -0400
Subject: Re: Linux: Why software RAID?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>, marc@perkel.com
In-Reply-To: <20060824090741.J30362@mail.kroptech.com>
References: <20060824090741.J30362@mail.kroptech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 14:20:50 +0100
Message-Id: <1156425650.3007.140.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 09:07 -0400, ysgrifennodd Adam Kropelin:
> Jeff Garzik <jeff@garzik.org> wrote:
> with sw RAID of course if the builder is careful to use multiple PCI 
> cards, etc. Sw RAID over your motherboard's onboard controllers leaves
> you vulnerable.

Generally speaking the channels on onboard ATA are independant with any
vaguely modern card. And for newer systems well the motherboard tends to
be festooned with random SATA controllers, all separate!

