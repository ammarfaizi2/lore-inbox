Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVF2A1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVF2A1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVF2A1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:27:03 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:63177 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262222AbVF2AZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:25:07 -0400
Message-ID: <2661.10.10.10.24.1120004702.squirrel@linux1>
In-Reply-To: <40A4071C-ED45-4280-928F-BCFC8761F47E@mac.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
    <20050624064101.GB14292@pasky.ji.cz>
    <20050624123819.GD9519@64m.dyndns.org>
    <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
    <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
    <3886.10.10.10.24.1119991512.squirrel@linux1>
    <20050628221422.GT12006@waste.org>
    <3993.10.10.10.24.1119997389.squirrel@linux1>
    <20050628224946.GU12006@waste.org>
    <4846.10.10.10.24.1119999568.squirrel@linux1>
    <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com>
    <1765.10.10.10.24.1120001856.squirrel@linux1>
    <40A4071C-ED45-4280-928F-BCFC8761F47E@mac.com>
Date: Tue, 28 Jun 2005 20:25:02 -0400 (EDT)
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
From: "Sean" <seanlkml@sympatico.ca>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: "Matt Mackall" <mpm@selenic.com>, "Petr Baudis" <pasky@ucw.cz>,
       "Christopher Li" <hg@chrisli.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Git Mailing List" <git@vger.kernel.org>, mercurial@selenic.com
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, June 28, 2005 8:08 pm, Kyle Moffett said:

> Firstly, no need to shout, we can all hear you :-D.

ok

>
> Git and Mercurial have all of the same core functionality.  The only
> significant remaining difference is that Mercurial uses 1/20th the
> network bandwidth and disk space.  If you happen to be interested in
> that advantage (as I am, due to my aging equipment and poor internet
> connection), then there are two options: (1) fix git, or (2) just use
> Mercurial.  From my point of view, option 2 is much more productive.
> You may (and probably do) have different priorities and requirements
> than I do, but in my view, Mercurial is an excellent tool.

well the feature set for both are changing rapidly.  i like the emphasis
placed on functionality over performance shown by the git developers (not
that git is slow, it's _way_ faster than bk ever was).  also the web
interface that i looked at for mecurial (admittedly four or fivve weeks
back) didn't come close to gitweb.   and the work done by jon seymour and
others on the history lineralization is just great.   it's something bk
lacked and was always a thorn in my side.

> Actually, Mercurial solved some of the problems first, before git did;
> distributed merge is one example that comes to mind.  In any case, I'm
> not trying to tell you what to use, I'm just pointing out alternatives
> that are available and explaining why I like them, in case you haven't
> seen them or tried them before.

there will be a price to pay if the linux community fragments over choice
of scm.  the good news is that we're no longer locked into the whims of
some proprietary system.  so it should be straight forward for those who
choose any tool to work with those who've chosen another.  this is already
evidenced by the fact that the git repository is pulled and re-exeported
with mecurial.

anyway, all the best, just wish you guys would spend less time trying to
convert git users and more time advancing your own tool.

sean


