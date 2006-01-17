Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWAQUs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWAQUs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWAQUs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:48:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41364 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932434AbWAQUs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:48:28 -0500
Date: Tue, 17 Jan 2006 21:48:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Mahoney <jeffm@suse.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] reiserfs: load bitmap blocks on demand
In-Reply-To: <20060117202930.GA24829@locomotive.unixthugs.org>
Message-ID: <Pine.LNX.4.61.0601172147410.30708@yvahk01.tjqt.qr>
References: <20060117202930.GA24829@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>* Loading all the bitmaps at file system mount takes a lot of time. On multi-
>  TB file systems, I've heard reports of file systems taking 15 minutes to
>  mount. There go your 5 9's after one reboot.
>
>I've run some overnight testing on this under heavy load, but I'd still like
>to see more testing before acceptance into mainline.
>
I'm in; testing it soon!



Jan Engelhardt
-- 
