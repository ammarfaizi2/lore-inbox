Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271913AbRH2Gad>; Wed, 29 Aug 2001 02:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271915AbRH2GaW>; Wed, 29 Aug 2001 02:30:22 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:33738 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271913AbRH2GaJ>; Wed, 29 Aug 2001 02:30:09 -0400
Date: Wed, 29 Aug 2001 02:30:27 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108290630.f7T6URU23063@devserv.devel.redhat.com>
To: bam@snoopy.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: USB flash card reader
In-Reply-To: <mailman.999063662.9386.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.999063662.9386.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> P:  Vendor=0781 ProdID=0001 Rev= 2.00
> S:  Manufacturer=SanDisk Corporation
> S:  Product=SanDisk USB ImageMate
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb-storage

Better bring this to linux-usb-devel@lists.sourceforge.net.
Ignore warnings from robat about the nazi submission policies,
it will get through eventually. The problem is, as you can see,
that it's not a Storage profile device, but vendor specific
(Class == 0xff). Only the author can help.

-- Pete
