Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290242AbSAXUkv>; Thu, 24 Jan 2002 15:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290237AbSAXUkc>; Thu, 24 Jan 2002 15:40:32 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:32775 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S290229AbSAXUkY>;
	Thu, 24 Jan 2002 15:40:24 -0500
Date: Wed, 23 Jan 2002 16:46:12 +0000
From: Pavel Machek <pavel@suse.cz>
To: baccala@freesoft.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: new virtualization syscall to improve uml performance?
Message-ID: <20020123164612.C78@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0201181312150.1000-100000@y2k.freesoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0201181312150.1000-100000@y2k.freesoft.org>; from baccala@freesoft.org on Fri, Jan 18, 2002 at 01:12:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Would this be just more kernel bloat to support one application?
> Perhaps not.  I have other utilities (a user-space HTTP file system,
> and code to do Plan 9-ish directory overlays) that need to intercept

See uservfs.sf.net, you do not need *so* heavy tools to do http fs.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

