Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTEMVdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbTEMVdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:33:01 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:12282 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263547AbTEMVc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:32:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The disappearing sys_call_table export.
Date: Tue, 13 May 2003 16:44:41 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305131048_MC3-1-38B1-E140@compuserve.com>
In-Reply-To: <200305131048_MC3-1-38B1-E140@compuserve.com>
MIME-Version: 1.0
Message-Id: <03051316444102.20373@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 May 2003 09:45, Chuck Ebbert wrote:
> Jesse Pollard wrote:
> > No - C2 evaluation has not been done for almost 3 years. That makes it
> > impossible to get a C2 evaluation.
>
>   The people who used to require that still have lists of approved
> operating systems.  Linux is not on that list.

Neither is windows, OS2, MAC 5/6/7/8/9/10.. for that matter.

> > And
> > "C2 like capability" Linux does just as well as M$. Are the log files as
> > pretty as would be desired? No. But they are acceptable for all US usage
> > where a UNIX system is acceptable.
>
>   "No audit trail" pretty much kills it right from the get-go.

It does have audit trails... you do have to turn on process accounting. Are
they pretty... no. But it is equivalent to base Solaris (well, before 2). You
also have to turn on logs from every service daemon.

>   Base Solaris has it.  And I'm pretty sure HP-UX 9 did but that was
> a while ago...

No current OS has C2 certifications - they have an EAL3 or 4. But not C2.

>   And real ACLs are only now getting into Linux... how long till someone
> certifies that they work is anyone's guess.

Real ACLs were available about 2-3 years ago. They just were not accepted
for inclusion, and the patch died.

First some organization has to come up with a good bit of $$$. Evaluations
are not cheap. It would take over a year to get an EAL3, and longer yet to
get 4.

> > These are also the same people that will not (or should not) accept
> > laptops in their environement.
>
>   Untrusted users shouldn't be allowed cellphones, PDAs, laptops or
> similar.
>
>   Next step up is probably full body cavity search to make sure you
> haven't hidden a Microdrive somehwere...

Remember the body scanner in that Mars based Schwartzenegger movie...
