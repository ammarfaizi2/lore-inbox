Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933864AbWKTCWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864AbWKTCWW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933861AbWKTCWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:22:21 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:44054 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S933858AbWKTCWU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:22:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Date: Mon, 20 Nov 2006 10:20:41 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0CEB975E@hkemmail01.nvidia.com>
In-Reply-To: <455DF9AE.3000406@garzik.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Thread-Index: AccKctYOUgPu1RKnRPmOHktBIsUW1wB144mg
From: "Peer Chen" <pchen@nvidia.com>
To: "Jeff Garzik" <jeff@garzik.org>, "Heikki Orsila" <shd@zakalwe.fi>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Prakash Punnoor" <prakash@punnoor.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       "Kuan Luo" <kluo@nvidia.com>
X-OriginalArrivalTime: 20 Nov 2006 02:20:45.0122 (UTC) FILETIME=[7C05DA20:01C70C4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your effort.

BRs
Peer Chen

-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org] 
Sent: Saturday, November 18, 2006 2:05 AM
To: Peer Chen
Cc: Christoph Hellwig; Prakash Punnoor; Andrew Morton;
linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org; Kuan Luo
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c

Peer Chen wrote:
> I didn't get any comment from you guys for new patch, does someone
take
> care this patch, do we still need some modification upon it? Or do we
> need re-submit it in other thread?

For my part, it's in my queue of things to review.  I need to figure out

the best way to export this support.

	Jeff



-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
