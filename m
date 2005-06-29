Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVF2AM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVF2AM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVF2AJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:09:48 -0400
Received: from smtpout.mac.com ([17.250.248.85]:49137 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261365AbVF2AI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:08:29 -0400
In-Reply-To: <1765.10.10.10.24.1120001856.squirrel@linux1>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org> <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com> <3886.10.10.10.24.1119991512.squirrel@linux1> <20050628221422.GT12006@waste.org> <3993.10.10.10.24.1119997389.squirrel@linux1> <20050628224946.GU12006@waste.org> <4846.10.10.10.24.1119999568.squirrel@linux1> <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com> <1765.10.10.10.24.1120001856.squirrel@linux1>
Mime-Version: 1.0 (Apple Message framework v730)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40A4071C-ED45-4280-928F-BCFC8761F47E@mac.com>
Cc: Matt Mackall <mpm@selenic.com>, Petr Baudis <pasky@ucw.cz>,
       Christopher Li <hg@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 20:08:17 -0400
To: Sean <seanlkml@sympatico.ca>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 19:37:36, Sean wrote:
> No, you seem to miss the point.  Git already does everything Mercurial
> does, and does it pretty well too.  The _point_ was that if the big
> "feature" of Mercurial is it's on disk format, Git is perfectly  
> capable of
> copying it at any point.   The on disk format just ISN'T CLOSE TO  
> BEING
> THE MOST IMPORTANT THING AT THE MOMENT.

Firstly, no need to shout, we can all hear you :-D.

Git and Mercurial have all of the same core functionality.  The only
significant remaining difference is that Mercurial uses 1/20th the
network bandwidth and disk space.  If you happen to be interested in
that advantage (as I am, due to my aging equipment and poor internet
connection), then there are two options: (1) fix git, or (2) just use
Mercurial.  From my point of view, option 2 is much more productive.
You may (and probably do) have different priorities and requirements
than I do, but in my view, Mercurial is an excellent tool.

> Yes, so what's your point?  Mercurial is trying to solve a problem  
> that is
> already perfectly well handled for me by Git.   Therefore I have  
> _zero_
> motivation to direct my efforts elsewhere.

Actually, Mercurial solved some of the problems first, before git did;
distributed merge is one example that comes to mind.  In any case, I'm
not trying to tell you what to use, I'm just pointing out alternatives
that are available and explaining why I like them, in case you haven't
seen them or tried them before.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------

