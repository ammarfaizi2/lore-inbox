Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUFYPgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUFYPgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUFYPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:36:51 -0400
Received: from gprs214-83.eurotel.cz ([160.218.214.83]:47488 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266289AbUFYPgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:36:50 -0400
Date: Fri, 25 Jun 2004 17:33:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-ID: <20040625153327.GA11220@elf.ucw.cz>
References: <20040617223517.59a56c7e.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617223517.59a56c7e.zap@homelink.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds lcd and backlight driver classes so that the
> lowlevel lcd and backlight power controls can be separated from
> framebuffer drivers.

Nice... Do you have any example driver that uses this?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
