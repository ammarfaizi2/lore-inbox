Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSJUUtS>; Mon, 21 Oct 2002 16:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSJUUtR>; Mon, 21 Oct 2002 16:49:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5640 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261668AbSJUUtQ>; Mon, 21 Oct 2002 16:49:16 -0400
Date: Mon, 21 Oct 2002 16:54:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: kexec for 2.5.44 (Who do I send this to?)
In-Reply-To: <1035203491.27259.71.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021021164506.4564B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Oct 2002, Alan Cox wrote:

> I will start picking stuff up now I'm back and catching up on email
> (I've been away for a week). I'm not however interested in kexec or ltt
> or a lot of the other large stuff so don't bother resending me that kind
> of thing.

I can appreciate that you are more interested in stability than features
now, and that's good in general. However, someone should be looking at
functional stuff like this, because it's (a) out and working and (b) adds
a whole new and important capability to Linux.

When I look at things like zero copy NFS and Reiser-4, my first impression
is that they are essentially incremental improvements to existing
features. And as hard as I've yelled about NFS4, I have been told that is
too. But things like JFS, XFS and kexec generate that "Holy shit, look
what they added now!" feeling. And as a whole new capability I really
would like to see it go in, even as I appreciate that it's not your job, I
hope it becomes someone's job, because I sure boot a lot of slow computers
on a regular basis :-(
 
> I really want to collect up bug fixes/compile fixes/driver updates and
> small but ready to merge stuff like the console updates if James Simmons
> is paying attention.
> 
I realize that you're busy, but there seem to be a shitload of drivers
which work compiled in and not as modules.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

