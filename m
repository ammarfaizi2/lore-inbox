Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUEJWc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUEJWc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUEJWcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:32:15 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:43668 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261989AbUEJWbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:31:43 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 15:31:40 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
In-Reply-To: <1084227460.28663.8.camel@vertex>
Message-ID: <Pine.LNX.4.58.0405101521280.1156@bigblue.dev.mdolabs.com>
References: <1084152941.22837.21.camel@vertex>  <20040510021141.GA10760@taniwha.stupidest.org>
 <1084227460.28663.8.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, John McCutchan wrote:

> > 3) dnotify cannot easily watch changes for a directory hierarchy
> 
> People don't seem to really care about this one. Alexander Larsson has
> said he doesn't care about it. It might be nice to add in the future.

Please excuse my ignorance, but who is Alexander Larsson? A dnotify 
replacement that does not have the ability to watch for a hierarchy is 
pretty much useless. Or do you want to drop thousands of single watches to 
accomplish that?



- Davide

