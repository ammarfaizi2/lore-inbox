Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEFKX>; Fri, 5 Jan 2001 00:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbRAEFKO>; Fri, 5 Jan 2001 00:10:14 -0500
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:24794 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129267AbRAEFKB>; Fri, 5 Jan 2001 00:10:01 -0500
Message-ID: <000e01c076d5$dd4370b0$8d19b018@c779218a>
From: "Nicholas Knight" <tegeran@home.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Subject: Fw: Change of policy for future 2.2 driver submissions
Date: Thu, 4 Jan 2001 21:10:47 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

since Mark posted his views to the list, I figured I could safely post the
conversation I've been having with him in email


----- Original Message -----
From: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
To: "Nicholas Knight" <tegeran@home.com>
Sent: Thursday, January 04, 2001 8:44 PM
Subject: Re: Change of policy for future 2.2 driver submissions


> > > I can safely claim that I've used 2.3 and 2.4 a lot more than you.
> > > while there have certainly been some bad kernels, many of them
> > > have been far more stable than any 2.2.
> >
> > Alan Cox himself has said he doesn't entirely trust 2.4, you're going to
> > dispute him?
>
> absolutely.

Alan Cox has the most credability in my view of any person in the linux
community (this is just my view, but I think it's pretty safe to say that
Alan is a very respected member of the linux community.) If he doesn't
entirely trust a kernel, I don't think I'd be very willing to either... this
combined with my experiences with 2.3 and 2.4 kernels leads me to mistrust
2.4 untill it's more refined

>
> > > > the simple fact is, DEVELOPMENT HAS TO OCCUR TO KEEP UP WITH CURRENT
> > > > HARDWARE AND NEEDS!
> > >
> > > I'm curious why you think 2.4 was developed at all.
> >
> > 2.4 contained MASSIVE changes to MANY aspects of the kernel, that's why
it's
> > 2.4 and not 2.2.19
> > 2.2.x's that included new drivers were neccisary while 2.4 was in
>
> I guess you don't read 2.2 patches.  it has contained MASSIVE changes
> to MANY aspects of the kernel.  about the only thing that has been
> off-limits is the SMP locking strategy (and that, by the way, is what
> Alan says his policy has been.)
>
<snip>
> > take ATA/66 support, this needed to be avalible in a stable kernel, but
it
> > wasn't in original 2.2 kernels, but was added in 2.2.12 (or 14, can't
recall
> > precisely at the present time if it was .12 or .14)
>
> so 2.2 transmorgrified from "stable" to "development for conservatives"
> because 2.4 took so long.

according to kernel.org, there were *seven* 2.2 kernels not including the
original 2.2.0 prior to the day 2.3.0 was posted
there was also an 8th 2.2 kernel posted just hours before 2.3.0 was posted
on may 11th of 1999
this is not an abnormal pattern for linux
the linux kernel is simply too complex and still isn't to a point where you
can wait very long between kernel changes (i.e. as long as 2.2 to 2.4
took... or how long it would have taken even if 2.2 development had
completely *HALTED* and *everyone* concentraited *Entirely* on 2.4
again, take ATA/66, it should be considered an essential component of the
kernel, it NEEDED to be there, if they'd waited for 2.4 and all the changes
it had incorporated, there would have been some major problems



>
> > if you really feel this way, why not post it to the kernel list? then
maybe
>
> did.
>
> > when enough people explain it, you'll understand why development
continues
> > on stable kernels after they've been released
>
> nonsense.
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
