Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUEKELK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUEKELK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 00:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUEKELK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 00:11:10 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:26549 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262050AbUEKELG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 00:11:06 -0400
Date: Mon, 10 May 2004 21:11:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040511041103.GA20404@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex> <Pine.LNX.4.58.0405101521280.1156@bigblue.dev.mdolabs.com> <1084228900.28903.2.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084228900.28903.2.camel@vertex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 06:41:40PM -0400, John McCutchan wrote:

> Alexander Larsson is the maintainer of nautilus, gnome-vfs and I
> think the dnotify patch for fam. He made a post to l-k a month or
> two ago about why he doesn't care about it. I do plan on adding this
> feature in the near future though.

I found the posting, it doesn't explain why dnotify using signals is
bad and I still don't see how inotify makes the situation any better.


  --cw
