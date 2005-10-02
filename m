Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVJBSK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVJBSK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 14:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVJBSK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 14:10:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5581 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751129AbVJBSK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 14:10:26 -0400
Date: Sun, 2 Oct 2005 20:10:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Spitalnik <lkml@spitalnik.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: thinkpad suspend to ram and backlight
Message-ID: <20051002181001.GB2181@elf.ucw.cz>
References: <20051002175703.GA3141@elf.ucw.cz> <200510022007.29660.lkml@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510022007.29660.lkml@spitalnik.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> > video chips is not turned off, too). Unfortunately, backlight is not
> > turned even when lid is closed. I know some patches were floating
> > around to solve that... but I can't find them now. Any ideas?
> 
> if your thinkpad has ati radeon, you can use this:
> 
> http://www.thinkwiki.org/wiki/Radeontool

There were patches floating around. I'd like to see those patches even
if I can work around that with radeontool.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
