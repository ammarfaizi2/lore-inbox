Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVBOTy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVBOTy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVBOTwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:52:00 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61887 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261856AbVBOTvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:51:08 -0500
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
From: Lee Revell <rlrevell@joe-job.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: prakashp@arcor.de, paolo.ciarrocchi@gmail.com, gregkh@suse.de,
       pmcfarland@downeast.net, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050215004329.5b96b5a1.diegocg@gmail.com>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>
	 <20050215004329.5b96b5a1.diegocg@gmail.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 14:51:06 -0500
Message-Id: <1108497066.7826.33.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 00:43 +0100, Diego Calleja wrote:
> There's stuff that it could be done in the kernel to help improving those numbers,
> IMHO.
> 
> xp logs all the io done the first two minutes after booting. The next time it boots
> it tries to read all those files at once so the programs will find stuff in memory
> instead of having to do lots of small seeks.

Thanks for the detailed explanation.  ISTR hearing that some of the
distros are working on similar solutions.  Now this would be a big win,
as anyone who has seen how much faster XP boots than Win2K can tell you.
And would certainly require kernel support.

Of course resuming from suspend will always be faster than booting but
for the forseeable future we will have to reboot from time to time.  And
XP's boot time currently is way, way better than ours.  FWIW, OSX still
takes forever to boot so we are not the only ones with this problem.

I wonder if XP's solution is patented.

Lee

