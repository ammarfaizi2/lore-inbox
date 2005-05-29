Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVE2Hvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVE2Hvz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 03:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVE2Hvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 03:51:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14239 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261269AbVE2Hvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 03:51:53 -0400
Date: Sun, 29 May 2005 09:51:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 00/13] Input patches for 2.6.12
Message-ID: <20050529075154.GA1738@ucw.cz>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529044813.711249000.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 11:48:13PM -0500, Dmitry Torokhov wrote:

> Hi Linus,
> 
> I have prepared some input patches that I would like to see in 2.6.12.
> Most of them are coming from Vojtech's BK tree and were in -mm for quite
> some time. They fix a warning in pmouse module, allow OSS drivers to
> be compiled when gameport support is disabled, fix joystick button
> mapping, broken mapping for right "win" key and more.
> 
> Please consider pulling from:
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> 
> branch "for-linus"

Linus, this pull has my blessing.

I wasn't able to prepare it myself for health and other reason.
 
Thank you very much Dmitry. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
