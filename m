Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282877AbRLWOLr>; Sun, 23 Dec 2001 09:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282801AbRLWOLf>; Sun, 23 Dec 2001 09:11:35 -0500
Received: from f159.pav1.hotmail.com ([64.4.31.159]:39436 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S282523AbRLWOLJ>;
	Sun, 23 Dec 2001 09:11:09 -0500
X-Originating-IP: [128.107.253.38]
From: "Eyal Sohya" <linuz_kernel_q@hotmail.com>
To: tao@acc.umu.se, znmeb@aracnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Date: Sun, 23 Dec 2001 14:11:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F159dOZofu45XijWQK30000e232@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2001 14:11:03.0605 (UTC) FILETIME=[A7F48650:01C18BBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: David Weinehall <tao@acc.umu.se>
>To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
>CC: Eyal Sohya <linuz_kernel_q@hotmail.com>, linux-kernel@vger.kernel.org
>Subject: Re: The direction linux is taking
>Date: Tue, 18 Dec 2001 16:18:45 +0100
>
>On Tue, Dec 18, 2001 at 06:38:26AM -0800, M. Edward (Ed) Borasky wrote:
> > On Tue, 18 Dec 2001, Eyal Sohya wrote:
> >
> > > I've watched this List and have some questions to ask
> > > which i would appreciate are answered. Some might not
> > > have definite answers and we might be divided on them.
> >
> > My opinions only!!
> >
> >
> > > 1. Are we satisfied with the source code control system ?
> >
> > With CVS, probably -- it's open source and rather universally known.
> > With the version control *process* ... well ... I personally favor a
> > full SEI CMM level 2 or even level 3 process. Whether there are open
> > source tools to facilitate that process is another story.
> >
> > > 2. Is there enough planning for documentation ? As another poster
> > > mentioned, there are new API and we dont know about them.
> >
> > There is, as it turns out, a tremendous *amount* of documentation,
> > although it is not as centralized as it could be. Again, I favor the SEI
> > CMM model.
> >
> > > 3. There is no central bug tracking database. At least people should
> > > know the status of the bugs they have found with some releases.
> >
> > Absolutely! Bug tracking and source / version control ought to be
> > integrated and centralized.
> >
> > > 4. Aggressive nature of this mailing list itself may be a turn off to
> > > many who would like to contribute.
> >
> > Well ... peer review / code walkthroughs are part of SEI CMM level 3
> > IIRC, and peer review is an important part of the scientific process. We
> > all have our opinions and our reasons for being here and levels of
> > contribution we are willing and able to make. When all is said and done,
> > more is said than done :)). A lot *is* getting done! The only things I
> > would change about this list are a reliable digest, a *vastly* better
> > search engine and a better mailing list manager than majordomo.
>

No one is asking for a SEI CMM level type of model for kernel
development. A system of checks and development so that things
that used to work dont get broken is hardly too much to expect.

This isnt asking for too much isnt it ?

Is a bug database on drivers and kernel subsystems asking for
a SEI CMM level type model ?

i dont think so.

>With SEI CMM level 3 for the kernel, complete testing and documentation,
>we'd be able to release a new kernel every 5 months, with new drivers
>2 years after release of the device, and support for new platforms
>2-3 years after their availability, as opposed to 1-2 years before
>(IA-64, for instance...)
>
>We'd also kill off all the advantages that the bazaar-style development
>style actually has, while gaining nothing in particular, except for
>a slow machinery of paper-work. No thanks.
>
>I don't complain when people do proper documentation and testing of
>their work; rather the opposite, but it needs to be done on a volunteer
>basis, not being forced by some standard. Do you really think Linus
>would be able to take all the extra work of software engineering? Think
>again. Do you honestly believe he'd accept doing so in a million years?
>Fat chance.
>
>Grand software engineering based on PSP/CMM/whatever is fine when you
>have a clear goal in mind; a plan stating what to do, detailing
>everything meticously. Not so for something that changes directions on
>pure whim from one week to the next, with the only goal being
>improvement, expansion and (sometimes) simplification. Yes, some people
>have a grand plan for their subsystems (I'm fairly convinced that
>Alexander Viro has some plans up his sleeve for the VFS, and I'm sure it
>involves a lot of ideas from Plan 9. But this is pure speculation, of
>course...) and there are some goals (such as the pending transition to a
>bigger dev_t, CML2, kbuild 2.5 et al), but most development takes place
>as follows: idea -> post on lkml -> long discussion -> implementation ->
>long discussion (about petty details) -> inclusion/rejection -> possible
>rehash of this...
>
>
>Regards: David Weinehall
>   _                                                                 _
>  // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
>//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
>\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </




_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

