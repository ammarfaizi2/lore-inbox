Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263392AbSJFM4q>; Sun, 6 Oct 2002 08:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbSJFM4q>; Sun, 6 Oct 2002 08:56:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23248 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263392AbSJFM4p>;
	Sun, 6 Oct 2002 08:56:45 -0400
Date: Sun, 6 Oct 2002 15:13:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re:  BK MetaData License Problem?
In-Reply-To: <3DA02F30.8040904@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, Manfred Spraul wrote:

> Where is the problem? This asks for a permission, not for exclusive
> rights.

yes, but what i say is that BK *creates* a problem, (just like CVS would
create similar problems) and the license clearly shows that BM is aware of
and tries to handle part of this legal problem. (And given that the BK
metadata is richer than eg. CVS, i suspect it will be a magnified problem
later on.)

i surely would find it to be a problem if BitMover would be the only
entity that has clean legal permissions to host the whole Linux kernel
repository. Even if Larry does not intend this to be the case. (which
assumption i grant blindly.)

what we had so far, at least according to my understanding, is that people
sent patches to a public and well-archived list, and that the GPL-ing of
the patch did not happen because the mailing shows their intent [i sure
never mention that the patch is GPL-ed], but because by the act of mailing
to the public list and to Linus they *distributed* the derived work, and
thus the GPL's provisions wrt. redistribution trigger - and Linus is fair
to pick the patch up.

the commit message on the other hand is the same as eg. SuSE's PR
announcement of SuSE Linux 20.9, it's metadata connected to their
publishing of a GPL-ed piece of code, but it's otherwise copyright and
owned by SuSE. The pure fact that a commit message about a GPL-ed work is
distributed publicly does not necessarily trigger any licensing of the
commit message itself.

> What's missing is a comment in the BK-usage document that informs the
> submitter that he must give the permission to republish the commit info.  
> i.e. asking Linus to pull from an url is not a private message to Linus,
> it's the equivalent of sending a mail to a public, moderated mailing
> list.

well, republishing permission is not enough i guess to keep the Linux
kernel tree as one entity i suspect. Plus even if a commit message is sent
to a public list, it does not necessarily mean it's put into the public
domain or something equivalent to that.

perhaps the best solution would be to make this part of BKL.txt - to give
protection to *both* BM and the Linux community. After all the commit is
performed by the owner of the commit message, so a good point for legal
stuff to trigger is in BKL.txt.

	Ingo

