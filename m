Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUITMJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUITMJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUITMJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:09:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:58335 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266352AbUITMJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:09:05 -0400
Date: Mon, 20 Sep 2004 14:07:52 +0200
From: Olaf Hering <olh@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920120752.GA23315@suse.de>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <Pine.LNX.4.61.0409201220200.3460@scrub.home> <20040920105618.GB24928@suse.de> <Pine.LNX.4.61.0409201311050.3460@scrub.home> <20040920112607.GA19073@suse.de> <Pine.LNX.4.61.0409201331320.3460@scrub.home> <20040920115032.GA21631@suse.de> <Pine.LNX.4.61.0409201357540.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0409201357540.877@scrub.home>
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
> > > $ mount -oloop image /mnt
> > > 
> > > vs
> > > 
> > > $ losetup image /dev/loop0
> > > $ mount /dev/loop0 /mnt
> > > 
> > > What should umount do, when called with /mnt?
> > 
> > I have /dev/loop0 in /proc/mounts, umount does nothing wrong here.
> 
> What exactly is that "nothing wrong"?

It umounts /mnt for me.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
