Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265445AbRF0Xlw>; Wed, 27 Jun 2001 19:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbRF0Xlm>; Wed, 27 Jun 2001 19:41:42 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:50531 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265445AbRF0XlW>; Wed, 27 Jun 2001 19:41:22 -0400
Date: Wed, 27 Jun 2001 19:41:21 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106272341.f5RNfLa10538@devserv.devel.redhat.com>
To: tom_gall@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <mailman.993682861.9307.linux-kernel2news@redhat.com>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <3B3A5B00.9FF387C9@mandrakesoft.com> <mailman.993682861.9307.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well you have device drivers like the symbios scsi driver for instance that
> tries to determine if it's seen a card before. It does this by looking at the
> bus,dev etc numbers...

Can it be done by comparing struct pci_dev pointers for equal?

-- Pete
