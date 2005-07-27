Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVG0XrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVG0XrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVG0Xot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:44:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261205AbVG0XnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:43:24 -0400
Date: Wed, 27 Jul 2005 16:43:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [git pull] jfs update
In-Reply-To: <20050727180547.6E5CE82BC4@kleikamp.dyn.webahead.ibm.com>
Message-ID: <Pine.LNX.4.58.0507271642160.3227@g5.osdl.org>
References: <20050727180547.6E5CE82BC4@kleikamp.dyn.webahead.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jul 2005, Dave Kleikamp wrote:
>
> Linus, please pull from
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus

Please use the format "repo branch" in your pull requests, ie since the 
real branch is called "for-linus", just say

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

which ends up being the syntax I have to use anyway ;)

		Linus
