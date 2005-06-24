Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263225AbVFXI0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbVFXI0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbVFXI0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:26:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:26275 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263225AbVFXIY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:24:56 -0400
Date: Fri, 24 Jun 2005 01:24:36 -0700
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050624082436.GA26381@kroah.com>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <20050623062842.GE17453@mikebell.org> <20050623064847.GC11638@kroah.com> <20050623082859.GD955@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623082859.GD955@mikebell.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<flame war snipped>

I've taken the time that I would have spent responding to this email
thread, and to other people who for some reason don't like to respond to
mailing lists but want to pester me privatly with "don't delete devfs"
type emails, and written ndevfs, a replacement in less than 300 lines
(including all needed hooks in the kernel).

If this does not meet your needs to keep devfs for your embedded
systems, please respond to the ndevfs post with the patch on lkml.

greg k-h
