Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbVKWWXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVKWWXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbVKWWXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:23:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12934 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030334AbVKWWXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:23:24 -0500
Date: Wed, 23 Nov 2005 23:23:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123222315.GC24220@elf.ucw.cz>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 22-11-05 13:31:16, Jon Smirl wrote:
> There have been recent comments about the pace of kernel development
> slowing. What are the major areas that still need major work? When the
> thread slows down maybe Linus will tell us what the top ten items
> really are.
> 
> To get things started here's a few that I would add:
> 
> 1) graphics, it is a total mess.
> 
> 2) get Xen merged, virtualization will be key on the server.
> Hotplugable CPUs and memory are tied up in this one.
> 
> 3) Reiser4 merge, Rieser4 itself is not important, it's the new
> concepts about file systems that Reiser4 brings to the kernel that are
> important. Get the issues around the VFS layer sorted out so that this
> can happen. We need some forward evolution in file system concepts.
> 
> 4) Merge klibc and fix up the driver system so that everything is
> hotplugable. This means no more need to configure drivers in the
> kernel, the right drivers will just load automatically.

5) Runtime power management

its just not there, or alternatively give me

6) E=mc^2 battery from the recent supercomputer thread

, which nicely solves 

7) word domination, 

too.

								Pavel
-- 
Thanks, Sharp!
