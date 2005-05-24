Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVEXSxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVEXSxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVEXSxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:53:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48260 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261375AbVEXSxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:53:01 -0400
Date: Tue, 24 May 2005 20:52:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jiri Benc <jbenc@suse.cz>
Cc: NetDev <netdev@oss.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: [0/5] Improvements to the ieee80211 layer
Message-ID: <20050524185241.GB2470@elf.ucw.cz>
References: <20050524150711.01632672@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524150711.01632672@griffin.suse.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The ieee80211 layer, now present in -mm, lacks many important features
> (actually it's just a part of the ipw2100/ipw2200 driver; these cards do
> a lot of the processing in the hardware/firmware and thus the layer
> currently can not be used for simpler devices).
> 
> This is the first series of patches that try to convert it to a generic
> IEEE 802.11 layer, usable for most of today's wireless cards.

Are they against -rc4-mm2?

Would it be possible to put agregate patch on the web somewhere (or
git tree?). I would certainly be easier to test....
								Pavel
