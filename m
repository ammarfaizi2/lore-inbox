Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288477AbSATXBp>; Sun, 20 Jan 2002 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSATXBf>; Sun, 20 Jan 2002 18:01:35 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:65122 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S288477AbSATXBQ>; Sun, 20 Jan 2002 18:01:16 -0500
Date: Sun, 20 Jan 2002 23:01:04 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler updates, -J2
Message-ID: <20020120230102.A7373@sackman.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201181710520.10122-100000@localhost.localdomain> <20020119221928.A2042@sackman.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020119221928.A2042@sackman.co.uk>; from matthew@sackman.co.uk on Sat, Jan 19, 2002 at 10:19:29PM +0000
From: matthew@sackman.co.uk (Matthew Sackman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 10:19:29PM +0000, Matthew Sackman wrote:
> On Fri, Jan 18, 2002 at 07:18:10PM +0100, Ingo Molnar wrote:
> > 
> > the -J2 O(1) scheduler patch is available:
> > 
> >     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-pre1-J2.patch
> >     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J2.patch
> <snips> 

One other thing that I've noticed, switching virtual workspaces will reliably
cause xmms to stutter. If you switch rapidly then it is exacerbated.

Matthew
