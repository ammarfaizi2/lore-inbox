Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbRGRTTo>; Wed, 18 Jul 2001 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRTTY>; Wed, 18 Jul 2001 15:19:24 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:56401 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267833AbRGRTTS>; Wed, 18 Jul 2001 15:19:18 -0400
Date: Wed, 18 Jul 2001 15:19:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107181919.f6IJJKK05088@devserv.devel.redhat.com>
To: frey@scs.ch
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Right Semantics for ioremap, remap_page_range
In-Reply-To: <mailman.995466971.12450.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.995466971.12450.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is an io_remap_page_range, which does a
> remap_page_range(virt_to_phys(ioremap(pci_resource_start()))) on
> Alpha, but this does not work either.

Kick the Alpha maintainer.

-- Pete
