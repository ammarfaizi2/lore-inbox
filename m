Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSIBLYl>; Mon, 2 Sep 2002 07:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSIBLYk>; Mon, 2 Sep 2002 07:24:40 -0400
Received: from mx0.gmx.de ([213.165.64.100]:7581 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S317851AbSIBLYk>;
	Mon, 2 Sep 2002 07:24:40 -0400
Date: Mon, 2 Sep 2002 13:29:05 +0200 (MEST)
From: Michael Kerrisk <m.kerrisk@gmx.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: bulb@vagabond.cybernet.cz, bulb@cimice.maxinet.cz,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20020827144421.5ebec0e4.sfr@canb.auug.org.au>
Subject: Re: Question about leases
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005657596@gmx.net
X-Authenticated-IP: [194.230.165.150]
Message-ID: <24161.1030966145@www61.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 27 Aug 2002 14:35:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
> >
> > On Tue, 27 Aug 2002 03:06:16 +0200 Jan Hudec <bulb@cimice.maxinet.cz>
> wrote:
> > >
> > > Please can anyone throw a bit light on file leases (fcntl F_SETLEASE
> > > command) or at least point me to some documentation? I can't find any.
> > 
> > There isn't any (except maybe the talk I gave at Linux Kongress
> > last year (http://www.canb.auug.org.au/~sfr/idle.html).

Not quite true.  I wrote some additions to the fcntl(2) manual page
describing leases.  Download a recent copy of the man pages from tldp.org.

Cheers

Michael

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

