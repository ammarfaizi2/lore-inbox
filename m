Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVKFU01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVKFU01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKFU01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:26:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9094 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751204AbVKFU01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:26:27 -0500
Date: Sun, 6 Nov 2005 21:26:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
Message-ID: <20051106202609.GA12481@elf.ucw.cz>
References: <20051106013752.GA13368@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106013752.GA13368@swissdisk.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Some people may have noticed the new git tree located at:
> 
> rsync.kernel.org:/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6.git
> 
> This tree will directly reflect the Ubuntu Linux Kernel that is available
> in our distribution (along with build system). First use of this kernel
> tree is slated for Dapper Drake (Ubuntu 6.04), and will stay synced with
> the just released 2.6.14(.y).
> 
> There are several reasons for making this repo available on kernel.org.
> Primary reasons include a more open development model, better visibility
> with the kernel developer community, and to make the kernel available to
> other distro's who may want to base their kernel off of ours.

Heh, I'm interested. We were thinking about using git for internal
suse kernel trees, but we thought it would not work, as we need more
something like quilt. Do you really use git internally, or do you just
export to it? If git is usable for distro develompent... that would be
good news. 

								Pavel
-- 
Thanks, Sharp!
