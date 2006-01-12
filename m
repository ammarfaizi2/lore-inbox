Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWALSSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWALSSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWALSSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:18:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932350AbWALSSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:18:03 -0500
Date: Thu, 12 Jan 2006 10:17:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git tree] drm tree for 2.6.16-rc1
In-Reply-To: <Pine.LNX.4.58.0601120948270.1552@skynet>
Message-ID: <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jan 2006, Dave Airlie wrote:
> 
> Hi Linus,
> 	Can you pull the drm-forlinus branch from
> git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> 
> This is a pretty major merge over of DRM CVS, and every driver in the DRM
> is brought up to latest versions....

I'm actually somewhat inclined to not pull any more. We've had lots of 
(hopefully minor) issues for the last few days, and I know that people 
had DRM issues with the -mm tree (which I assume tracked this tree) not 
more than a week or so ago.

IOW, I want to make sure that my tree is somewhat stable again. I don't 
want -rc1 to be horrible.

		Linus
