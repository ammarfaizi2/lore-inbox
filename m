Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTAZPTH>; Sun, 26 Jan 2003 10:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbTAZPTH>; Sun, 26 Jan 2003 10:19:07 -0500
Received: from www.wireboard.com ([216.151.155.101]:58275 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S266939AbTAZPTG>; Sun, 26 Jan 2003 10:19:06 -0500
To: Peter Karlsson <peter@softwolves.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel crashes while scanning partition list
References: <Pine.LNX.4.43.0301261152230.28040-100000@perkele>
From: Doug McNaught <doug@mcnaught.org>
Date: 26 Jan 2003 10:28:10 -0500
In-Reply-To: Peter Karlsson's message of "Sun, 26 Jan 2003 11:53:58 +0100 (CET)"
Message-ID: <m365sclylx.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Karlsson <peter@softwolves.pp.se> writes:

> Me, last week:
> 
> > I am installing Debian Linux on my new Athlon XP PC, and I have
> > problems with the 2.4.20 kernel crashing on boot.
> 
> So, no one has any good ideas on what might be wrong with the 2.4.20
> kernel? I must say that it's quite irritating to have a brand new
> computer just standing around unusable because I can't run Linux on it
> :-(

Have you tried 2.4.21pre?  It may have fixes to handle newer hardware.

Does the machine pass memtest86?

-Doug
