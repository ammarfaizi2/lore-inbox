Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbRAYWBQ>; Thu, 25 Jan 2001 17:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRAYWBF>; Thu, 25 Jan 2001 17:01:05 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:18442
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129703AbRAYWAv>; Thu, 25 Jan 2001 17:00:51 -0500
Date: Thu, 25 Jan 2001 14:00:15 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
In-Reply-To: <Pine.LNX.4.21.0101251348540.23727-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.10.10101251358230.18634-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where the flip are you form this power starved portion of the world?
Also the subject is AMD and VIA chipsets not AMD CPU's running on VIA
chipsets.

What chipset or host is causing you the problem?

VIA pr Promise?

On Thu, 25 Jan 2001, David D.W. Downey wrote:

> 
> 
> OK, I see you guys releasing patches for the AMD + VIA problem, but this
> problem is NOT just limited to the AMD problem. I'm using Intel PIII-733s
> and the VIA VT82C686A chipset. No AMD CPUs in ANY of my VIA boxes. When
> are we going to see something for the MSI boards?
> 
> My board in particular is the MSI 694D Pro using the VIA VT82C686A chipset
> and the Promise PDC20265 ATA100 onbard controller.
> 
> I need some sort of help with this. I'm getting kernel deaths left and
> right and no hope in sight here.
> 
> I though it might possibly be a mix of SCSI + IDE causing troubles so I
> borrowed a 18GB SCSI drive from a buddy and attached it to my Advansys
> SCSI card (not sure of the make offhand. I can find the box when I get
> home as I'm at work right now.)
> 
> I would code up a fix if I knew what the hell I was doing when it came to
> coding which I do NOT.
> 
> Vojtech, can you please work with me on this issue? Or if you are too
> busy, can you put me in contact with someone who can help? I've got a
> $3000 machine sitting here that I can not do a damn thing with until I
> stop these blasted kernel deaths! (Yeah I'm pissed, but at the situation
> not at the kernel or anyone involved with the VIA stuff. Please don't take
> it that way.)
> 
> David Downey
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
