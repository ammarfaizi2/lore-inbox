Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUITMm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUITMm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUITMm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:42:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:23964 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266463AbUITMmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:42:54 -0400
Date: Mon, 20 Sep 2004 14:38:28 +0200
From: Olaf Hering <olh@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920123828.GA25684@suse.de>
References: <20040920105618.GB24928@suse.de> <Pine.LNX.4.61.0409201311050.3460@scrub.home> <20040920112607.GA19073@suse.de> <Pine.LNX.4.61.0409201331320.3460@scrub.home> <20040920115032.GA21631@suse.de> <Pine.LNX.4.61.0409201357540.877@scrub.home> <20040920120752.GA23315@suse.de> <Pine.LNX.4.61.0409201413030.877@scrub.home> <20040920121949.GA24304@suse.de> <Pine.LNX.4.61.0409201428430.3460@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0409201428430.3460@scrub.home>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 20, Roman Zippel wrote:

> Hi,
> 
> On Mon, 20 Sep 2004, Olaf Hering wrote:
> 
> > > What happens to /dev/loop0?
> > 
> > I dont know, whats supposed to happen? losetup -d?
> 
> Yes, depending on how it was mounted, but that information isn't in 
> /proc/mounts.
> (BTW how difficult was it to find this out yourself? Have you even tried 
> it?)

Sure I have tried it. I wonder why umount doesnt do the losetup? I have
never looked at the umount sources, nor have I played with all the
possible ways of loop mount.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
