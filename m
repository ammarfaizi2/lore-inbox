Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbUKOQxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUKOQxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 11:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUKOQx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 11:53:27 -0500
Received: from magic.adaptec.com ([216.52.22.17]:29114 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261635AbUKOQxS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 11:53:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] SCSI aacraid: make some code static
Date: Mon, 15 Nov 2004 11:53:15 -0500
Message-ID: <60807403EABEB443939A5A7AA8A7458B5C0F02@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] SCSI aacraid: make some code static
Thread-Index: AcTLKQuBl2MoR+vnRAemnlzNc9fyCwACijEw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Adrian Bunk" <bunk@stusta.de>
Cc: "James Bottomley" <James.Bottomley@SteelEye.com>,
       <linux-scsi@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already incorporated the changes :-) I probably should have chimed
in with my support for this patch.

Sincerely -- Mark Salyzyn 

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Alan Cox
Sent: Monday, November 15, 2004 9:27 AM
To: Adrian Bunk
Cc: James Bottomley; linux-scsi@vger.kernel.org; Linux Kernel Mailing
List
Subject: Re: [2.6 patch] SCSI aacraid: make some code static

On Llu, 2004-11-15 at 01:49, Adrian Bunk wrote:
> The patch below makes some needlessly global code static.
> 
> It also removes the completely unused global function 
> aac_consumer_avail.

Looks good to me but make sure you send a copy on to the maintainer
<mark_salyzyn@adaptec.com> as he'll want it for the development drivers
(and we want that because there are a pile of new cards 8))

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
