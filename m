Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265699AbSJSX5Y>; Sat, 19 Oct 2002 19:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSJSX5Y>; Sat, 19 Oct 2002 19:57:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11020
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265699AbSJSX5U>; Sat, 19 Oct 2002 19:57:20 -0400
Date: Sat, 19 Oct 2002 17:01:13 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Toon van der Pas <toon@vanvergehaald.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
In-Reply-To: <20021020012057.B4900@vdpas.hobby.nl>
Message-ID: <Pine.LNX.4.10.10210191645080.24031-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Toon van der Pas wrote:

> On Sat, Oct 19, 2002 at 03:54:46PM -0700, Andre Hedrick wrote:
> > On Sat, 19 Oct 2002, Brian Gerst wrote:
> > > 
> > > Attempting to read a "defective" disc should never, ever, cause a
> > > kernel oops.  Whether it succeeds or not is irrelevant.
> > 
> > Please point out where in the original post, the referrence to
> > "defective" media.  If this would have been the case, your point it
> > valid.  If I missed something, thus am wrong, I will admit to being
> > wrong.
> 
> AFAICS you missed something indeed:
> Attempts to read copy-protected media should also never result in a kernel oops.

True, however since I suspect the device was attempting to thwart and
crash the system, until a trace of the sense data returns from the device
and the re-action of the kernel to those target responses, not much can be
done to prevent such a crash.

Again, the world of copy-protection has no boundaries.

There is a product out there called a tether (sp).

By design it will white screen and then blue screen the MicroSoft
environment.  If you continue to attempt to violate the ACL of the
device/media combination it will become a tattle-tail and send email to a
specified server and include all the evidence to charge you with a crime.

I agree this is silly but the DMCA/RIAA/MPAA and company are out to hurt
people and their rights.

When was the last time you called the MPAA's general council and tell the
lead attorney and clearly stated you would oppose any new changes into the
a specification regardless?  I did it about a year ago.

Now it is only going to get worse.

Recall SCSI via MMC is tainted.
Recall SAS is being pushed into SATA as SATA II.
Now since SATA II will be effectively under SAS which is under SAM
overseen by T10 and STA, this all translate to SATA/SATAPI devices will
totally polluted like SCSI is today.

Now is there a way to win at this game, I am working on it.

These people are sneaky and in the dark.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

