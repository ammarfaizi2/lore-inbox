Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbRFFKHO>; Wed, 6 Jun 2001 06:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRFFKHE>; Wed, 6 Jun 2001 06:07:04 -0400
Received: from [213.221.172.237] ([213.221.172.237]:38357 "EHLO
	smtp-relay2.barrysworld.com") by vger.kernel.org with ESMTP
	id <S261535AbRFFKGu>; Wed, 6 Jun 2001 06:06:50 -0400
From: "DBs \(ML\)" <dbsml@barrysworld.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Break 2.4 VM in five easy steps
Date: Wed, 6 Jun 2001 11:06:10 +0100
Message-ID: <HDEOIOONDALNHDIJADIFAEECFBAA.dbsml@barrysworld.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What happens if the box is full of disk capacity and you cannot add anymore
spindles?

Then what?

Upgrade the whole disk subsystem just to cater for this issue? That would
turn out to be a bit more expensive in both money terms and downtime/labour
costs.

It really annoys me when people just say "Add more of this then....".


Best regards

Antonio Covelli


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Dr S.M. Huen
> Sent: Wednesday, June 06, 2001 10:58 AM
> To: Sean Hunter
> Cc: Xavier Bestel; linux-kernel@vger.kernel.org
> Subject: Re: Break 2.4 VM in five easy steps
>
>
> On Wed, 6 Jun 2001, Sean Hunter wrote:
>
> >
> > For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> >
>
> Do I understand you correctly?
> ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
> at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
> drives.
>
> It will cost you 19x as much to put the RAM in as to put the
> developer's recommended amount of swap space to back up that RAM.  The
> developers gave their reasons for this design some time ago and if the
> ONLY problem was that it required you to allocate more swap, why should
> it be a priority item to fix it for those that refuse to do so?   By all
> means fix it urgently where it doesn't work when used as advised but
> demanding priority to fixing a problem encountered when a user refuses to
> use it in the manner specified seems very unreasonable.  If you can afford
> 4GB RAM, you certainly can afford 8GB swap.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

