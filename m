Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWGZMaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWGZMaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGZMaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:30:14 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:34712 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1751453AbWGZMaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:30:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: oops in scsi_device_put after PCMCIA based USB HC is ejected
Date: Wed, 26 Jul 2006 17:59:52 +0530
Message-ID: <0F35D2C4458E9B4A9891BE2D4E0C83900138CE56@PNE-HJN-MBX01.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: oops in scsi_device_put after PCMCIA based USB HC is ejected
Thread-Index: AcauU7ZHR8oE3N2nSUydD7DpDeju5ACWoR/A
From: <deepti.chotai@wipro.com>
To: <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2006 12:30:10.0955 (UTC) FILETIME=[3CA06DB0:01C6B0AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Sunday, July 23, 2006 6:00 PM
> To: Deepti Chotai (WT01 - Semiconductors & Consumer Electronics)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: oops in scsi_device_put after PCMCIA based USB HC is
ejected
> 
> On Sun, 23 Jul 2006 15:17:02 +0530
> <deepti.chotai@wipro.com> wrote:
> 
> > I am working on a HCD for an OHCI compliant USB Host Controller on a
> > PCMICIA card for 2.6.15.4 kernel.
> 
> We've changed an awful lot of things in that area since 2.6.15.  It'd
be
> best if you could retest 2.6.18-rc2, please.

We are in the last stage of development currently. Porting the drivers
to 2.6.18-rc2 will be not be feasible for us, in the available time
frame. Could you please suggest any patches for the kernel 2.6.15.4 or
indicate the changes that have been made.

Thanks for your help.

-Deepti
