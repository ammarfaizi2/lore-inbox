Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUEMPhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUEMPhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUEMPhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:37:10 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:61705 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264262AbUEMPhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:37:05 -0400
Date: Thu, 13 May 2004 23:36:38 +0800 (WST)
From: raven@themaw.net
To: John McCutchan <ttb@tentacle.dhs.org>
cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
In-Reply-To: <1084152941.22837.21.camel@vertex>
Message-ID: <Pine.LNX.4.58.0405132330480.13693@donald.themaw.net>
References: <1084152941.22837.21.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi John.

On Sun, 9 May 2004, John McCutchan wrote:

> Hi,
> 
> I have been working on inotify a dnotify replacement. 

I have a rather unusual requirement for notification events.

I've had a brief look at the code but it doesn't look like it would 
cater for it.

Would this allow me to receive a notification when a directory is 
passed over during a path walk?

Could this strategy be adapted to notify an in kernel module?
Or is this overkill for what I'm asking?

Ian

