Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTIDVw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTIDVw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:52:56 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:9651 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265589AbTIDVwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:52:31 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: root@chaos.analogic.com
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 4 Sep 2003 22:51:38 +0100
User-Agent: KMail/1.5
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com> <Pine.LNX.4.53.0309041723090.9557@chaos>
In-Reply-To: <Pine.LNX.4.53.0309041723090.9557@chaos>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042251.38514.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is exactly the kind of FUD that is slowing Linux development and 
preventing wider use. Windows, for all its faults is a VERY BIG commercial 
success. You (and I) may believe that MS have persued some pretty bad 
practises to get where they are but the FACT is they are there and YOU are 
here.  You may (I don't) believe that Windows is inherently unstable. This is 
FUD. It mostly works, sometimes it doesn't, but in total the number of 
working hours of PRODUCTIVE use from it is many orders of magnitude greater. 
Multiple the number of Windows users in the world by their working time and 
then do the same for Linux! 

I have not proposed a driver model that is compatible with the Windows DDK. 
This is pure invention from the usual school of 'Windows v Linux, Linux is 
better because we made it'. The Linux driver model could be much better and 
hence the OS could escape the niche box it currently is in. Please ask Joe 
User how he feels about rebuilding his whole OS to add IP6 support to an 
existing stable system etc.

You have accused me of not knowing anything about OS design. I don't what your 
knowledge is, so I won't try and score points by telling you about mine - 
what I do know is that you obviously don't appreciate what is holding Linux 
back - You.

James



On Thursday 04 Sep 2003 10:29 pm, you wrote:
> On Thu, 4 Sep 2003, James Clark wrote:
> > Thank you for this (and the few other) sensible appraisal of my
> > 'proposal'.
> >
> > I'm very surprised by the number of posts that have ranted about
> > Open/Close source, GPL/taint issues etc. This is not about source code it
> > is about making Linux usable by the masses. It may be technically
> > superior to follow the current model, but if the barrier to entry is very
> > high (and it is!) then the project will continue to be a niche project. A
> > binary model doesn't alter the community or the benefits of public source
> > code. I agree that it is an extra interface and will carry a performance
> > hit - I think this is worth it. Windows has many faults but drivers are
> > often compatible across major releases and VERY compatible across minor
> > releases. It is no accident that it has 90% of the desktop market. If we
> > are going to improve this situation this issue MUST be confronted.
> >
> > I am currently collating the arguments for and (mostly) against the idea.
> > If I don't get flamed in the meantime I may come back with more...
> >
> > James
>
> The problem with Windows users is not that they are
> stupid or even uneducated. It's just that they have been
> taught that using a widely-used operating system that
> is defective in design and implementation is the way
> that operating systems should be.
>
> They have been taught that bugs are normal. "Every program
> has bugs. It is impossible to check all possible execution
> paths to verify that there are no bugs, etc." This kind
> of teaching comes about when the teachers know little or
> nothing about their subjects and simply parrot what they
> have read in literature that, in many cases, has been written
> by the very persons who are incapable of writing bug-free code.
>
> They have been taught that the secret inner workings of
> the kernel are best treated like the objects of an object-
> oriented design. In fact, they are taught that it's
> harmful for a programmer, much less a user, to understand
> the underlying workings of the operating system. This
> is taught because Microsoft doesn't want you to know what
> an abysmal abortion the operating system is.
>
> Before Microsoft, nobody would dare sell a product that
> contained no warranty at all. Somehow, Microsoft has taught
> its customers that they should never expect software to
> actually work. Somehow, their lawyers have replaced the
> usual; "We warrant this product to be free of defects in
> workmanship and design for a period ..."  to a disclaimer
> that many persons think is some kind of a warranty. In
> most cases, you can't even take a defective CD, defective
> because it can't be read, back to the vendor without
> encountering; "On it's software. Nobody warrants that!"
>
> You can thank Microsoft for this.
>
> There have been billions and billions of dollars of
> lost productivity in industry because of this defective
> Operating System.  In one company alone, there was
> over one million dollars lost last year to defective
> software. You can look at the financial filings of
> many of the publically-traded companies and see write-
> offs due to defective software in this order of magnitude.
> Multiply that by the number of companies in the world to
> get the big picture.
>
> And, somehow, companies still keep using that garbage!
>
> Linux is something different. It strives for perfection.
> There is no way in hell that you are going to add some
> Microsoft-compatible driver interface to Linux. There
> are no drivers that could ever work on Windows and
> somehow work on Linux. These two systems are mutually
> exclusive, Alpha-Omega, 0->inf, good-evil, absolutely the
> antithesis of each other. I hear that's why Microsoft is
> attempting to kill Linux by funding the SCO lawsuit (check
> this week's EETimes, I didn't make it up).
>
> Now, you propose to introduce a driver interface that is
> defective in concept. You propose this because you just
> don't get it. You just don't know anything about Operating
> Systems and you just don't know anything about Linux.
>
> It may not be your fault. There are lots of people who
> haven't a clue because they have been taught things that
> are simply not true at all. And, once you repeat a falsehood
> enough times it becomes accepted as fact.
>
> Before you can become qualified to propose a different
> driver interface, you need to learn about Operating Systems.
> I know that you do not know anything about Operating Systems
> in general, because of your proposal.
>
> I suggest that you read a book like "Developing Your Own
> 32-bit Operating System", Burges, H.W.Sams, ISBN 0-627-30655-7
> This is an interesting book because it is not about Windows
> and it's not about Linux. It's about a roll-your-own Operating
> System. It even comes with a CD and you can boot a home-grown
> system on your PC.
>
> Now, I don't care if you studied Operating Systems in College.
> In fact, that just might be the reason why you don't know what
> you are talking about. Most such college courses in this subject
> are absolute crap, written by Masters candidates who learned
> a bunch of words and coined a few of their own.
>
> After you learn about Operating Systems, then you might be able
> to add some new capability to Linux. You know, they accept patches
> here. If you've got a better way, you make a patch and we'll all
> try it. It's really that simple.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
>             Note 96.31% of all statistics are fiction.

