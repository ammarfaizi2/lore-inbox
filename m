Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135236AbRAYVGs>; Thu, 25 Jan 2001 16:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRAYVGl>; Thu, 25 Jan 2001 16:06:41 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:2313 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S135236AbRAYVGV>; Thu, 25 Jan 2001 16:06:21 -0500
Date: Thu, 25 Jan 2001 13:06:14 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Micah Gorrell <angelcode@myrealbox.com>
cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 problems in 2.4.0
In-Reply-To: <006601c08711$4bdfb600$9b2f4189@angelw2k>
Message-ID: <Pine.LNX.4.31ksi3.0101251305030.6635-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Micah Gorrell wrote:

I do have such a problem with the machines that have only one eepro100 nic.

> Because of the problems we where having we are no longer using the
> machine
> with 3 nics.  We are now using a machine with just one and it is going
> live
> next week.  We do need kernel 2.4 because of the process limits in 2.2.
> Does the 'Enable Power Management (EXPERIMENTAL)' option fix the no
> resources problems?
>
> Micah
> ___
> The irony is that Bill Gates claims to be making a stable operating
> system
> and Linus Torvalds claims to be trying to take over the world
> -----Original Message-----
> From: "Tom Sightler" <ttsig@tuxyturvy.com>
> To: "Micah Gorrell" <angelcode@myrealbox.com>;
> <linux-kernel@vger.kernel.org>
> Date: Thursday, January 25, 2001 1:48 PM
> Subject: Re: eepro100 problems in 2.4.0
>
>
> > > I have doing some testing with kernel 2.4 and I have had constant
> >problems
> >> with the eepro100 driver.  Under 2.2 it works perfectly but under
> 2.4 I
> am
> >> unable to use more than one card in a server and when I do use one
> card I
> >> get errors stating that eth0 reports no recources.  Has anyone else
> seen
> >> this kind of problem?
> >
> >I had a similar problem with a server that had dual embedded eepro100
> >adapters however selecting the 'Enable Power Management
> (EXPERIMENTAL)'
> >option for the eepro100 seemed to make the problem go away.  I don't
> really
> >know why but it might be worth trying if it wasn't already selected.
> >
> >Later,
> >Tom
> >
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >Please read the FAQ at http://www.tux.org/lkml/
> >
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
>

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8890
Henderson, NV, 89014

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
