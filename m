Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290701AbSA3WkK>; Wed, 30 Jan 2002 17:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290698AbSA3WkA>; Wed, 30 Jan 2002 17:40:00 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:30299 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S290701AbSA3Wjy>; Wed, 30 Jan 2002 17:39:54 -0500
Date: Wed, 30 Jan 2002 16:39:48 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil>
To: landley@trommello.org, "Matthew D. Pitts" <mpitts@suite224.net>,
        "Chris Ricker" <kaboom@gatech.edu>,
        "Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130210212.ZYOS23516.femail25.sdc1.sfba.home.com@there>
Cc: "World Domination Now!" <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------
Rob Landley <landley@trommello.org>:
> 
> On Wednesday 30 January 2002 07:49 am, Matthew D. Pitts wrote:
> > Chris,
> >
> > Thank you for saying this... I have things I would like do/add to the
> > kernel and I am not sure who to send them to.
> 
> No, if you're not a maintainer then you still send them to the maintainer in 
> the MAINTAINERS file.
> 
> The interesting question is, who does THAT maintainer send them to.  (We seem 
> to be heading for a four-tiered system, with Linus at the top, a dozen or so 
> lieutenants under him, and then the specific maintainers under them.  With 
> individual developers submitting patches being the fourth tier.  Patches go 
> from developer, to maintainer, to lieutenant, to linus.)
> 
> This doesn't sound like a bad thing for scalability reasons, and should also 
> help address the "I sent my patch directly to linus a dozen times and I 
> didn't hear back" problem.
> 
> The problem right now is a lot of the maintainers don't seem to know who 
> their corresponding lieutenant is.  We're still waiting for clarification 
> from Linus...

Ummm. this might be silly, but shouldn't those announcements come from
the lieutenants?

Linus has announced who he accepts patches frin, and who will be doing the 2.0,
2.2, and 2.4 maintenance. It would seem logical to have those lieutenants
announce their maintainers.

How would Linus actually know who, (after his lieutenants) SHOULD send mail
to the lieutenants?

That is the problem in the first place...

It would help to have the information in the MAINTAINERS file though. As well
as the auxilary mailing lists supporting that activity. That way, users
who find a bug/create a patch/whatever would have an easier time locating
where to send the patch. Especially when it doesn't directly affect the
core kernel.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
