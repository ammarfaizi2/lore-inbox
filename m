Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWATWdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWATWdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWATWdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:33:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932247AbWATWdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:33:55 -0500
Date: Fri, 20 Jan 2006 14:35:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [ALSA PATCH] Sync with CVS
Message-Id: <20060120143548.0fd4751a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0601202033150.19304@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0601202033150.19304@tm8103.perex-int.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela <perex@suse.cz> wrote:
>
> Linus, please do an update from:
> 
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

Linus is presently in the PDX departure lounge, on his way to finding out
how hard Kiwis bite.

And I doubt if he'll be merging this - too big, too late.  I guess that's
why he ducked your January 16 pull request too.

I think it would be best at this stage if you were, over the next week, to
cherrypick just the bugfixes and send those along for 2.6.16.
