Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbVLOMti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbVLOMti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVLOMti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:49:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28648 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965202AbVLOMth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:49:37 -0500
Date: Thu, 15 Dec 2005 13:49:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 3/3] m68k: compile fix - updated vmlinux.lds to include
 LOCK_TEXT
In-Reply-To: <20051215090037.GV27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0512151347180.1605@scrub.home>
References: <20051215090037.GV27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2005, Al Viro wrote:

> [rz: BTW, proposed variant of thread_info patchset is available for review,
> see ftp.linux.org.uk/pub/people/viro/task_thread_info-mbox...  Doesn't
> do any incompatible changes, mergable at leisure, reduces the remaining
> renaming to ~50 lines - the only chunk that will have to go at 2.6.16...]

Looks good, but what I still don't understand is why you couldn't do this 
on top of my patches. I'm waiting now to get all this resolved, before I 
want to queue any other large patches.

bye, Roman
