Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUACB6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbUACB6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:58:51 -0500
Received: from mx11.sac.fedex.com ([199.81.193.118]:36112 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S262308AbUACB6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:58:50 -0500
Date: Sat, 3 Jan 2004 09:45:16 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Michael Hunold <hunold@convergence.de>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
In-Reply-To: <3FF5986C.8060806@convergence.de>
Message-ID: <Pine.LNX.4.58.0401030932280.948@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
 <20040102103949.GL5523@suse.de> <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
 <3FF5986C.8060806@convergence.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 09:58:45 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 09:58:48 AM,
	Serialize complete at 01/03/2004 09:58:48 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jan 2004, Michael Hunold wrote:

> > scsi0 : SCSI emulation for USB Mass Storage devices
> >   Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> > sr0: scsi-1 drive

Michael,

Thanks for the pointer and the patch. Now I can successfully use mplayer
on my usb drive. I decided to use Jens' patch as it's simpler.

Thanks,
Jeff.

