Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSLBSbK>; Mon, 2 Dec 2002 13:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLBSbJ>; Mon, 2 Dec 2002 13:31:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25107 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264814AbSLBSbI>; Mon, 2 Dec 2002 13:31:08 -0500
Date: Mon, 2 Dec 2002 13:37:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@redhat.com>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: LM sensors into kernel?
In-Reply-To: <200212011703.gB1H34T19752@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1021202133323.433C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Alan Cox wrote:

> > What is preventing lm-sensors from being merged into kernel? Alan,
> > given nice patch for current kernel, would you accept lm-sensors into
> > your kernel?
> 
> Linus call not mine.

Really? I know he controls what goes in the mainline, but I thought you
put in what you found useful in your kernel. Certainly rmap was there
until it was old enough to vote.

Clearly lm_sensors do have value in a production environment.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

