Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUEJWjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUEJWjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUEJWjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:39:01 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:36018
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S262215AbUEJWiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:38:55 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: John McCutchan <ttb@tentacle.dhs.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405101521280.1156@bigblue.dev.mdolabs.com>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
	 <1084227460.28663.8.camel@vertex>
	 <Pine.LNX.4.58.0405101521280.1156@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084228900.28903.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 18:41:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 18:31, Davide Libenzi wrote:
> On Mon, 10 May 2004, John McCutchan wrote:
> 
> > > 3) dnotify cannot easily watch changes for a directory hierarchy
> > 
> > People don't seem to really care about this one. Alexander Larsson has
> > said he doesn't care about it. It might be nice to add in the future.
> 
> Please excuse my ignorance, but who is Alexander Larsson? A dnotify 
> replacement that does not have the ability to watch for a hierarchy is 
> pretty much useless. Or do you want to drop thousands of single watches to 
> accomplish that?

Alexander Larsson is the maintainer of nautilus, gnome-vfs and I think
the dnotify patch for fam. He made a post to l-k a month or two ago
about why he doesn't care about it. I do plan on adding this feature in
the near future though.

John

