Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSLBTMB>; Mon, 2 Dec 2002 14:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSLBTMB>; Mon, 2 Dec 2002 14:12:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29971 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264839AbSLBTMA>; Mon, 2 Dec 2002 14:12:00 -0500
Date: Mon, 2 Dec 2002 14:18:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@redhat.com>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: LM sensors into kernel?
In-Reply-To: <200212021842.gB2Igou00740@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1021202140938.433H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Alan Cox wrote:

> > Really? I know he controls what goes in the mainline, but I thought you
> > put in what you found useful in your kernel. Certainly rmap was there
> > until it was old enough to vote.
> > 
> > Clearly lm_sensors do have value in a production environment.
> 
> 2.4-ac is a bit different. 2.5-ac is stuff Im holding to get a working
> 2.5 to test with. Im trying to avoid getting anything in it Linus wont
> have taken by 2.6.0

Okay, thanks. I was hoping since lm_sensors were proposed before the
freeze, relatively stable, and highly useful that they might get in.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

