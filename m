Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVBWDY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVBWDY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 22:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVBWDY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 22:24:29 -0500
Received: from waste.org ([216.27.176.166]:33408 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261396AbVBWDY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 22:24:26 -0500
Date: Tue, 22 Feb 2005 19:24:13 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 0/6] Bind Mount Extensions 0.06
Message-ID: <20050223032413.GB3163@waste.org>
References: <20050222120955.GA3682@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222120955.GA3682@mail.13thfloor.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 01:09:55PM +0100, Herbert Poetzl wrote:
> 
> Hi Andrew! Al! Folks!
> 
> The following set of patches extends the per device 
> 'noatime', 'nodiratime' and last but not least the 
> 'ro' (read only) mount option to the vfs --bind mounts, 
> allowing them to behave like any other mount, by 
> honoring those mount flags (which are silently ignored 
> by the current implementation in 2.4.x and 2.6.x)   	

Please give each patch a unique, descriptive subject. Summarizing what
each patch is doing in your 0/n so that reviewers can focus on the
bits that are interesting is also helpful.

-- 
Mathematics is the supreme nostalgia of our time.
