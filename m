Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVIKRU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVIKRU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVIKRU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:20:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:27274 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751094AbVIKRU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:20:27 -0400
Date: Sun, 11 Sep 2005 10:17:21 -0700
From: Greg KH <gregkh@suse.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050911171720.GB12106@suse.de>
References: <20050909214542.GA29200@kroah.com> <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz> <20050911030726.GA20462@suse.de> <Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 11:08:36PM -0700, David Lang wrote:
> remember that the distros don't package every kernel, they skip several 
> between releases and it's not going to be until they go to try them that 
> all the kinks will get worked out.

I don't know of any major distro that ships devfs with a 2.6 kernel, do
you?

> add to this the fact that many people have gotten confused about kernel 
> releases and think that since 13 is odd 2.6.13 is a testing kernel and 
> 2.6.14 will be a stable one and so won't look at .13

Well, they should not think this, a number of us have been trying our
best to get the word out as to how the current kernel development cycle
works.

> note that all this assumes that the issues that people have about sysfs 
> not yet being able to replace that capabilities that they are useing in 
> devfs have been addressed.

Hm, that happened a long time ago...

Unless anyone else knows of anything missing?

thanks,

greg k-h
