Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285440AbRLGTOs>; Fri, 7 Dec 2001 14:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285471AbRLGTOj>; Fri, 7 Dec 2001 14:14:39 -0500
Received: from [198.17.35.35] ([198.17.35.35]:57050 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S285440AbRLGTOY>;
	Fri, 7 Dec 2001 14:14:24 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B29B8@OTTONEXC1>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Larry McVoy'" <lm@bitmover.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: SMP/cc Cluster description
Date: Fri, 7 Dec 2001 11:14:13 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Man you guys are NUTS.

But this is a fun conversation so I'm going to join in.

> Did you even consider that this is virtually identical to the problem
> that a network of workstations or servers has?  Did it occur 
> to you that
> people have solved this problem in many different ways?  Or 
> did you just
> want to piss into the wind and enjoy the spray?

I may be a total tool here, but this question is really bugging me :

What, if any, advantages does your proposal have over (say) a Beowulf
cluster?  Why does having the cluster in one box seem a better solution
than having a Beowulf type cluster with a shared Network filesystem?

You've declared everything to be separate, so that I can't see
what's not separate any more :)

Is it just an issue of shared memory?  You want to be able to share
memory between processes on separate systems at high speed?  Why
not Myrinet then?  Yeah, it's slower, but the order of magnitude
reduction in cost compared to a 64 way SMP box makes this a trivial
decision in my books....

Or am I missing something really obvious here????

Dana Lacoste
Embedded Linux Developer (The OPPOSITE side of the scale)
Ottawa, Canada
