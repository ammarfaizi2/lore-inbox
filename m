Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbTAZHiY>; Sun, 26 Jan 2003 02:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbTAZHiY>; Sun, 26 Jan 2003 02:38:24 -0500
Received: from mailsrv.otenet.gr ([195.170.0.5]:38864 "EHLO mailsrv.otenet.gr")
	by vger.kernel.org with ESMTP id <S266730AbTAZHiX>;
	Sun, 26 Jan 2003 02:38:23 -0500
Date: Sun, 26 Jan 2003 09:46:46 +0200
From: Giorgos Keramidas <keramida@ceid.upatras.gr>
To: Mike Bristow <mike@urgle.com>
Cc: Bill Studenmund <wrstuden@netbsd.org>,
       arief_mulya <arief@bna.telkomsel.co.id>, linux-kernel@vger.kernel.org,
       tech@openbsd.org, freebsd-hackers@FreeBSD.ORG, tech-kern@netbsd.org
Subject: Re: Technical Differences of *BSD and Linux
Message-ID: <20030126074646.GA1683@gothmog.gr>
References: <3E30C2A5.5040502@bna.telkomsel.co.id> <Pine.NEB.4.33.0301240937270.18483-100000@vespasia.home-net.icnt.net> <20030124225624.GB23410@lindt.urgle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124225624.GB23410@lindt.urgle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-01-24 22:56, Mike Bristow <mike@urgle.com> wrote:
> [ Reply-To set to me:  This is probably off topic for all of the lists:
>   all of the ones I read, anyway. ]
>
> On Fri, Jan 24, 2003 at 10:03:53AM -0800, Bill Studenmund wrote:
> > > 2. How does it differ? What are the technical reasoning
> > > behind the decisions?
> >
> > They differ in most technical areas. Mainly as the *BSD kernels were
> > derived from 4.4-Lite, and Linux was derived, I believe, from Minux. 
>
> Point of order:  Linux was a cleanroom implementation, using IIRC Minux
> as the host OS until such time as it became self-hosting.

It was "Minix", not Minux.  And Linux started as a clean room
implementation that was free from any Minix code, to avoid problems
with the license of Minix.  See the thread where Linus Torvalds
announced the creation of Linux in comp.os.minix below (if the URL
wraps, cut n' paste it to one line before checking it out):

http://groups.google.com/groups?amp;th=d161e94858c4c0b9&amp;rnum=6

