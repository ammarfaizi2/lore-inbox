Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290185AbSBKTJj>; Mon, 11 Feb 2002 14:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290125AbSBKTJ3>; Mon, 11 Feb 2002 14:09:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52998 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290185AbSBKTJL>; Mon, 11 Feb 2002 14:09:11 -0500
Date: Mon, 11 Feb 2002 14:08:14 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Michael Cohen <lkml@ohdarn.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.4.18-pre8-mjc
In-Reply-To: <B887BD9B.3D6%lkml@ohdarn.net>
Message-ID: <Pine.LNX.3.96.1020211140641.642B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Michael Cohen wrote:

> On 2/7/02 5:03 AM, "Tarkan Erimer" <tarkane@solmaz.com.tr> wrote:
> 
> > Your patch list is very nice. Is there any chance to add XFS patch, also?
> 
> Shawn Starr has been working on this.
> 
> > If so, it would be wonderful for me and the others , I think, who uses XFS
> > and want to use these patches, too. Because, if i patch my kernel with XFS,
> > i can't add other patches, like yours.
> 
> Personally I think XFS ought to stay in fs/xfs already and stop encroaching
> on the rest of the kernel.  It's also HUGE.  But hey, if Shawn wants to do
> it, let him do it.

The size is less an issue than having hooks all over the kernel, where
other features can/will break and be broken.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

