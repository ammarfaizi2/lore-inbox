Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSAIRQq>; Wed, 9 Jan 2002 12:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSAIRQl>; Wed, 9 Jan 2002 12:16:41 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:23185 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S288246AbSAIRPv>; Wed, 9 Jan 2002 12:15:51 -0500
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org, tom@infosys.tuwien.ac.at
Subject: Re: i810 kernel driver vs 7012
In-Reply-To: <86k7ut5qb2.fsf@notus.ireton.fremlin.de>
	<86itach48q.fsf@notus.ireton.fremlin.de> <3C3B72EE.8010803@redhat.com>
	<864rlwh328.fsf@notus.ireton.fremlin.de> <3C3B79BB.6090601@redhat.com>
	<86vgecfnec.fsf@notus.ireton.fremlin.de> <3C3B8C14.60508@redhat.com>
	<86u1twe3sw.fsf@notus.ireton.fremlin.de> <3C3B9B60.4010308@redhat.com>
	<86ofk4e2gz.fsf@notus.ireton.fremlin.de> <3C3BA00D.7020203@redhat.com>
	<86d70ke0rs.fsf@notus.ireton.fremlin.de> <3C3BA5E2.7050703@redhat.com>
	<861yh0dzlc.fsf@notus.ireton.fremlin.de> <3C3BB0B6.2070401@redhat.com>
	<867kqsmd05.fsf@notus.ireton.fremlin.de> <3C3BCAAD.50308@redhat.com>
	<861yh0m7ic.fsf@notus.ireton.fremlin.de> <3C3BD44A.4080008@redhat.com>
	<86vgeckrg4.fsf@notus.ireton.fremlin.de> <3C3C0CE5.5010005@redhat.com>
From: John Fremlin <john@fremlin.de>
In-Reply-To: <3C3C0CE5.5010005@redhat.com> (Doug Ledford's message of "Wed,
 09 Jan 2002 04:27:01 -0500")
Date: Wed, 09 Jan 2002 17:17:25 +0000
Message-ID: <86k7url9zu.fsf@notus.ireton.fremlin.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.5 (asparagus,
 i586-seventh-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford <dledford@redhat.com> writes:

[...]

> Problem identified.  It was a combination of two things.  In
[...]
> solved. Anyway, a new 0.18 version of the driver is up on my site.
> It should solve *all* of the particular problems you were seeing.
> Let me know how it works.

Works just super. Not an overrun in sight anywhere! Please submit it
for the kernel(s) so I don't have to apply yet another patch :-)

Thanks for nailing the problems, Doug! You must have put in a lot of
time on this yesterday and it was almost a pleasure to run those tests
because of the speed with which you came up with patches. Thanks once
again!

[Of course also qudos and thanks to Thomas Gschwind who got the SiS
7012 going in the first place!]

[...]
-- 

	http://john.fremlin.de

