Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVACRt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVACRt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVACRfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:35:14 -0500
Received: from mail.tmr.com ([216.238.38.203]:52235 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261530AbVACRbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:31:35 -0500
Date: Mon, 3 Jan 2005 12:21:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel M/L <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-ac2 - more cdrecord wierdness
In-Reply-To: <1104765568.12780.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050103121945.27655B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Alan Cox wrote:

> On Llu, 2005-01-03 at 04:08, Bill Davidsen wrote:
> > Just a FYI - I assume there's a good reason why reading the unclosed 
> > filesystem size would compromise security.
> 
> It may just be an oversight in the built in list of "safe" commands. Do
> you know what command is being rejected ? 
> 
Not yet. Finding out is on my to-do list for the weekend when I'm back
near that machine, but that weekend also has football playoffs, two hockey
games, a dinner and taking my wife to a movie. That means late Sunday
night is the most likely :-(


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

