Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZA0y>; Thu, 25 Jan 2001 19:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRAZA0o>; Thu, 25 Jan 2001 19:26:44 -0500
Received: from [64.160.188.242] ([64.160.188.242]:54798 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S130936AbRAZA0h>; Thu, 25 Jan 2001 19:26:37 -0500
Date: Thu, 25 Jan 2001 16:26:33 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
In-Reply-To: <Pine.LNX.4.10.10101251358230.18634-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0101251425480.23822-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LOL, I'm in Sunnyvale, CA right now. I work for Ensim.Com.



OK, here is all the technical info on my box. Sorry it took so long to
respond. Had a department meeting to attend.


MSI 694D Pro running Dual FC-PGA PIII-733 CPUs with 1GB of Corsair RAM.

HDD is a Western Digital WDC300BB-00AU1 ATA100 drive (running it on the
VIA controlled ATA33/66 controller since the kernel doesn't support the
ATA100 very well.)

Chipsets are the VIA VT82C686A and the Promise PDC20265

NIC is a NetGear FA-310TX

Advansys UW SCSI Card

Yamaha CRW8424S CDRW

Voodoo3 2000 AGP 16MB AGP video card.


APM/ACPI turned OFF in BIOS, NOT using the ATA100 controller


Symptoms: Consistantly recurring kernel deaths resulting in hard lock of
box.






 
On Thu, 25 Jan 2001, Andre Hedrick wrote:

> 
> Where the flip are you form this power starved portion of the world?
> Also the subject is AMD and VIA chipsets not AMD CPU's running on VIA
> chipsets.
> 
> What chipset or host is causing you the problem?
> 
> VIA pr Promise?
> 
> On Thu, 25 Jan 2001, David D.W. Downey wrote:
> 
> > 
> > 
> > OK, I see you guys releasing patches for the AMD + VIA problem, but this
> > problem is NOT just limited to the AMD problem. I'm using Intel PIII-733s
> > and the VIA VT82C686A chipset. No AMD CPUs in ANY of my VIA boxes. When
> > are we going to see something for the MSI boards?
> > 
> > My board in particular is the MSI 694D Pro using the VIA VT82C686A chipset
> > and the Promise PDC20265 ATA100 onbard controller.
> > 
> > I need some sort of help with this. I'm getting kernel deaths left and
> > right and no hope in sight here.
> > 
> > I though it might possibly be a mix of SCSI + IDE causing troubles so I
> > borrowed a 18GB SCSI drive from a buddy and attached it to my Advansys
> > SCSI card (not sure of the make offhand. I can find the box when I get
> > home as I'm at work right now.)
> > 
> > I would code up a fix if I knew what the hell I was doing when it came to
> > coding which I do NOT.
> > 
> > Vojtech, can you please work with me on this issue? Or if you are too
> > busy, can you put me in contact with someone who can help? I've got a
> > $3000 machine sitting here that I can not do a damn thing with until I
> > stop these blasted kernel deaths! (Yeah I'm pissed, but at the situation
> > not at the kernel or anyone involved with the VIA stuff. Please don't take
> > it that way.)
> > 
> > David Downey
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> Linux ATA Development
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
