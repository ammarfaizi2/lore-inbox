Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVBREPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVBREPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 23:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVBREPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 23:15:54 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:2515 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261261AbVBREPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 23:15:45 -0500
Message-Id: <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
To: "Sean" <seanlkml@sympatico.ca>
cc: "Chris Friesen" <cfriesen@nortel.com>, "Lee Revell" <rlrevell@joe-job.com>,
       "d.c" <aradorlinux@yahoo.es>, tytso@mit.edu, cs@tequila.co.jp,
       galibert@pobox.com, kernel@crazytrain.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed 
In-Reply-To: Message from "Sean" <seanlkml@sympatico.ca> 
   of "Thu, 17 Feb 2005 16:24:01 CDT." <4912.10.10.10.24.1108675441.squirrel@linux1> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 17)
Date: Thu, 17 Feb 2005 22:42:14 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sean" <seanlkml@sympatico.ca> said:
> On Thu, February 17, 2005 3:52 pm, Horst von Brand said:

[...]

> > "Best tool for the job" certainly includes minutiae like "benefits" and
> > "price".

> Thank you, that's my point.  It's not just about the geeky microscopic
> technical details.

Linus clearly considered not just his /own/ workflow, but the workflow for
the /whole/ kernel development community. In fact, BK was designed around
the requirements Linus and other head hackers laid down for a SCM for use
in Linux. And I'm quite sure that if Linus et al had serious misgivings
about the license somehow hindering Linux development, they would have got
it fixed or dumped BK. Linus has said time and again that he just cares for
the very best kernel possible, nothing else.

Sure, from the periphery of kernel development using something else looks
simple. But you have to consider there are literaly dozens of trees (of the
head maintainers) exchanging changesets. The flow of going into 2.6 is
astonishing right now, I'd say some 3 or 5 times more than what got into
the most furious 2.3 patch frenzies. Existing open source tools just aren't
up to the task, as Linus has repeatedly said. Just now there are starting
to be halfways useful SCM systems (almost all based on the "one central
repository" idea, which doesn't cut it for Linux), but they aren't proven
enough.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
