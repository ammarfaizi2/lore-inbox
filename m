Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUENHDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUENHDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 03:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbUENHDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 03:03:13 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:58384 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S265130AbUENG4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 02:56:07 -0400
Date: Fri, 14 May 2004 15:04:16 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Chris Wedgwood <cw@f00f.org>
cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       nautilus-list@gnome.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
In-Reply-To: <20040513190440.GA23111@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0405141455570.3012@wombat.indigo.net.au>
References: <1084152941.22837.21.camel@vertex> <Pine.LNX.4.58.0405132330480.13693@donald.themaw.net>
 <20040513190440.GA23111@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Chris Wedgwood wrote:

> On Thu, May 13, 2004 at 11:36:38PM +0800, raven@themaw.net wrote:
> 
> > Would this allow me to receive a notification when a directory is
> > passed over during a path walk?
> 
> No.  And are you sure you want this?
> 
> > Could this strategy be adapted to notify an in kernel module?
> 
> Maybe you should explain what you are trying to do...  getting a
> notification when a path element is walked sounds problematic of many
> levels.

I'm not trying to do anything atm.

I'm just fishing for ideas.

Ian

