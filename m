Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130459AbRCFLGk>; Tue, 6 Mar 2001 06:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130458AbRCFLG3>; Tue, 6 Mar 2001 06:06:29 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:10500 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S130430AbRCFLGR>;
	Tue, 6 Mar 2001 06:06:17 -0500
Date: Fri, 2 Mar 2001 00:52:26 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Ridge <newt@scyld.com>
Cc: beowulf@beowulf.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will Mosix go into the standard kernel?
Message-ID: <20010302005226.A35@(none)>
In-Reply-To: <Pine.LNX.4.33.0102271829030.5502-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0102281732210.22184-100000@eleanor.wdhq.scyld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0102281732210.22184-100000@eleanor.wdhq.scyld.com>; from newt@scyld.com on Wed, Feb 28, 2001 at 06:06:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The Scyld system is based on BProc -- which requires only a 1K patch to
> the kernel. This patch adds 339 net lines to the kernel, and changes 38
> existing lines.
> 
> The Scyld 2-kernel-monte kernel inplace reboot facility is a 600-line
> module which doesn't require any patches whatsoever.

There might be big difference in *complexity* of those patches. Distributions
only change "unimportant" stuff. And 600 lines module is not small, either..

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

