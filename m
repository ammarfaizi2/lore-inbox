Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312861AbSCVVxl>; Fri, 22 Mar 2002 16:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312862AbSCVVxd>; Fri, 22 Mar 2002 16:53:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46855
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312861AbSCVVxV>; Fri, 22 Mar 2002 16:53:21 -0500
Date: Fri, 22 Mar 2002 13:52:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        John Langford <jcl@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <Pine.LNX.4.10.10203221231430.10409-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10203221343290.11833-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan, 

I sent this out a heart beat early.

To totally clarify the very last part, this a standing offer of PEACE.
So if it is not accepted, the offer still stands.  Since I will most
likely be migrating into other storage areas, the object and goal of
"Taskfile" was to leave and infrastructure which totally described the
sub-system in closed form.  I had hoped to finish it before the transition
out of the development kernel happened but oh well, things did not work
out as planned.

If Martin will permit I will fix the transport, otherwise I can not tied
to it.  This will require him forcing the BLOCK layer to be modified per
the  model that Suparna and I co-authored.  This will benefit many other
devices.

The closing point is that I can flush the ego, and work w/ Martin.
He has a strong and weak suit just as I do.  The difference and benefit is
they oddly compliment.

Your serve Martin, volley up.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Fri, 22 Mar 2002, Andre Hedrick wrote:

> On Fri, 22 Mar 2002, Alan Cox wrote:
> 
> > > Since you are so knowledgeble about ATA, I am shocked that such as simple
> > 
> > Where did Martin ever claim that ?
> 
> Recall his comments during the clean up stages of where he had studied
> many other OS's ATA/ATAPI sub systems.  This clearly indicates one has or
> is presenting themselves withe a deep understanding if the issues.  One
> should recall the comments of comparing "taskfile" to MS Windows API.
> Since he has clearly pointed out the useless nature of the IOCTL and
> removed it in 2.5, he must have a better means of diagnotsics and testing
> than the rest of the industry.  So I am waiting on pins and needles for
> this evolution to reveal itself.
> 
> > > concept and a requirement of WHQL (Windows Hardware Qualifications Lab)
> > > tool kit is not in the front of you mind.  Do yourself a favor, and go
> > > learn about the hardware and what the REAL CUSTOMERS are requiring of it
> > > and then come back to play.  You are truly showing your total lack of
> > > knowledge of the global hardware industry.
> > 
> > He's trying to learn. Imagine if learning to drive consisted of someone
> > with a megaphone telling you you'll fail and doing nothing but laugh when
> > you crash ?
> > 
> > Now why do you think it'll work any better for IDE ?
> 
> Point taken and agreed, so as long has Mr. Dalecki will agree to a point
> of peace, we can move forward.  Obviously there is much about the top
> layer interface to the kernel that is not significant to me at this point,
> and he has a stronger grasp than I have an interest.  However the mockery
> of my knowledge of the physical/host transport is not acceptable.  I am
> perfectly will and agreeable to grant and give him the respect deserved,
> but I also expect and require the same.
> 
> Regards,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

