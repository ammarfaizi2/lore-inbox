Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSAITH3>; Wed, 9 Jan 2002 14:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288973AbSAITHL>; Wed, 9 Jan 2002 14:07:11 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:59920 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S288969AbSAITGv>; Wed, 9 Jan 2002 14:06:51 -0500
Date: Wed, 9 Jan 2002 13:06:45 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201091906.NAA20993@tomcat.admin.navo.hpc.mil>
To: lkml@andyjeffries.co.uk,
        "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Difficulties in interoperating with Windows
In-Reply-To: <20020109162944.1a48a5e7.lkml@andyjeffries.co.uk>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Wed, 9 Jan 2002 10:04:11 -0600 (CST), "Jesse Pollard"
> <pollard@tomcat.admin.navo.hpc.mil> wrote:
> > > But would it?  If you disassemble part/all of Windows and use the code
> > > to understand how it works, then use this to create a specification
> > > and write code to use that specification, there should be no problem?
> > 
> > As long as someone ELSE does the developement (this is the "clean room"
> > developement that lawyers like for the defence - it must also be fully
> > documented).
> 
> Hmmm, I don't know about that, as long as the (source) code is different,
> I don't think it can be argued that it was copied not created.  But that's
> probably a legal battle that no-one would want to get in to.

Yup - there are too many source code manglers that can make what appears to 
be significant changes that do nothing more that change field names, structure
names, and limited re-ordering of statements.

> > > Correct, but I'm not talking about recompiling Windows and selling it,
> > > I'm talking about decompiling it and using the decompiled source to
> > > make Linux work better with it.  That is completely legal.
> > 
> > Not really - M$ will come after you. That's why the problems with NTFS
> > still exist - the people that were working on it (even in a "clean
> > room") had to desist. They (as I understand it) eventually dropped their
> > M$ software. And NTFS is still read-only.
> 
> Are they US based developers?

I think they were/are.

> > > Reverse engineering for the sole:purpose of copying or duplicating
> > > programs constitutes a copyright:violation and is illegal. In some
> > > cases, the licensed use of software:specifically prohibits reverse
> > > engineering.
> >
> > And M$ will go after you because of the last two sentences. Especially
> > the "duplicating programs" part. They will (have?) claimed that
> > duplicating NTFS functionality is not legal. 
> 
> But the first of your two chosen sentences seems to read as
> copy/duplicating in the sense of piracy.  Obviously as it isn't 100%
> clear, then it would be a possible legal case for Microsoft, but to be
> honest I can't see the courts going with it.  Otherwise there would only
> be one product of each particular type of software.
> 
> As to the second: under UK law any license which tries to restrict the
> lawful users ability to decompile the product is expressly void.  They
> cannot enforce that portion of the contract under UK law (which a UK
> citizen buying Windows in the UK would come under).
> 
> > (I think Jeff Merkey was
> > the one doing this - He should the one to really comment on the problems
> > he had with M$).
> 
> I certainly would be interested in hearing his comments...is he here and
> watching this thread? :-)
> 
> > Also note - none of that definition addresses the ability to publish the
> > results.
> 
> OK, I understand not publishing the decompiled code, but what would be the
> problem is publishing your code.

Trade secrets, patented algorithms, DMCA ... I'm sure the lawyers can find
something.


-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
