Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSAIQdq>; Wed, 9 Jan 2002 11:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSAIQdh>; Wed, 9 Jan 2002 11:33:37 -0500
Received: from adsl-62-128-214-206.iomart.com ([62.128.214.206]:48379 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S287816AbSAIQd1>; Wed, 9 Jan 2002 11:33:27 -0500
Date: Wed, 9 Jan 2002 16:29:44 +0000
From: Andy Jeffries <lkml@andyjeffries.co.uk>
To: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Difficulties in interoperating with Windows
Message-Id: <20020109162944.1a48a5e7.lkml@andyjeffries.co.uk>
In-Reply-To: <200201091604.KAA18962@tomcat.admin.navo.hpc.mil>
In-Reply-To: <20020109152823.62f65b7c.andy@i-a.co.uk>
	<200201091604.KAA18962@tomcat.admin.navo.hpc.mil>
Organization: Scramdisk Linux
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002 10:04:11 -0600 (CST), "Jesse Pollard"
<pollard@tomcat.admin.navo.hpc.mil> wrote:
> > But would it?  If you disassemble part/all of Windows and use the code
> > to understand how it works, then use this to create a specification
> > and write code to use that specification, there should be no problem?
> 
> As long as someone ELSE does the developement (this is the "clean room"
> developement that lawyers like for the defence - it must also be fully
> documented).

Hmmm, I don't know about that, as long as the (source) code is different,
I don't think it can be argued that it was copied not created.  But that's
probably a legal battle that no-one would want to get in to.

> > Correct, but I'm not talking about recompiling Windows and selling it,
> > I'm talking about decompiling it and using the decompiled source to
> > make Linux work better with it.  That is completely legal.
> 
> Not really - M$ will come after you. That's why the problems with NTFS
> still exist - the people that were working on it (even in a "clean
> room") had to desist. They (as I understand it) eventually dropped their
> M$ software. And NTFS is still read-only.

Are they US based developers?

> > Reverse engineering for the sole:purpose of copying or duplicating
> > programs constitutes a copyright:violation and is illegal. In some
> > cases, the licensed use of software:specifically prohibits reverse
> > engineering.
>
> And M$ will go after you because of the last two sentences. Especially
> the "duplicating programs" part. They will (have?) claimed that
> duplicating NTFS functionality is not legal. 

But the first of your two chosen sentences seems to read as
copy/duplicating in the sense of piracy.  Obviously as it isn't 100%
clear, then it would be a possible legal case for Microsoft, but to be
honest I can't see the courts going with it.  Otherwise there would only
be one product of each particular type of software.

As to the second: under UK law any license which tries to restrict the
lawful users ability to decompile the product is expressly void.  They
cannot enforce that portion of the contract under UK law (which a UK
citizen buying Windows in the UK would come under).

> (I think Jeff Merkey was
> the one doing this - He should the one to really comment on the problems
> he had with M$).

I certainly would be interested in hearing his comments...is he here and
watching this thread? :-)

> Also note - none of that definition addresses the ability to publish the
> results.

OK, I understand not publishing the decompiled code, but what would be the
problem is publishing your code.

> Yes - but any software that is to be included in the Linux kernel must
> also be legal everywhere (well, especially the USA). Just look at the
> problems DECSS has had. and the cross agreements between the US and
> Europe are beginning to force some agreement to the limits on revers
> engineering. 

Maybe true, but surely though if the decompiling was done outside of the
US and the decompiled code not taken to the US, then the new code is
purely code that works with M$ products.

> Check the refusal of A.Cox to publish explainations of some
> security patches due to the DMCA.

I wonder AC's refusal was more of a statement on the ludicrousness of the
law rather than actually required.

> > Depends where you are in the world I guess.  I am specifically (in the
> > UK) given the right to do this.
> 
> But you are not allowed to republish.

Where does it say this?

> It also depends on the software - the way M$ is going, they may build in
> a detection for any access to the OS binaries (checkout that DRM
> patent). If it isn't from an approved program, the system just may wipe
> itself out (assuming it is running :-)

Hmm, an interesting point...although they'd be hard pressed to do that
when it's decompiled under Linux (extracted from the CAB files off the CD
and decompiled using a Linux tool).

> > Just interested in opinions on this...
> 
> Sure thing.

And thanks so far...

Must remember not to use my work (i-a) address in posts though...

Cheers,



-- 
Andy Jeffries                   | Scramdisk Linux Project
http://www.scramdisklinux.org   | Lead developer

"testing? What's that? If it compiles, it is good, if it boots up 
 it is perfect."
  --- Linus Torvalds
