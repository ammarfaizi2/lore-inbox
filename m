Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135844AbRDYMUV>; Wed, 25 Apr 2001 08:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbRDYMUA>; Wed, 25 Apr 2001 08:20:00 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135719AbRDYMT6>;
	Wed, 25 Apr 2001 08:19:58 -0400
Message-ID: <20010422165411.B198@bug.ucw.cz>
Date: Sun, 22 Apr 2001 16:54:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: Re: networked file system
In-Reply-To: <m33db3vv2m.fsf@nbecker.fred.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m33db3vv2m.fsf@nbecker.fred.net>; from nbecker@fred.net on Fri, Apr 20, 2001 at 10:35:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Suppose that an entry on any filesystem could be replaced by a symlink
> which pointed to a URL, and that an appropriate handler was dispatched
> for that URL.  This would allow, for example, config files to point to
> a different machine.
> 
> Right now we can accomplish this by mounting alternative file systems
> and symlinking to them, but only if an appropriate file system has
> been written.

See podfuk, recently moved to uservfs.sourceforge.net.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
