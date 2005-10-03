Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVJCKAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVJCKAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 06:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVJCKAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 06:00:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:53409 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932217AbVJCKAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 06:00:45 -0400
Message-ID: <43410149.9070007@suse.de>
Date: Mon, 03 Oct 2005 12:00:41 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?Timo_H=F6nig?= <thoenig@suse.de>
Subject: Re: thinkpad suspend to ram and backlight
References: <20051002175703.GA3141@elf.ucw.cz>
In-Reply-To: <20051002175703.GA3141@elf.ucw.cz>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> video chips is not turned off, too). Unfortunately, backlight is not
> turned even when lid is closed. I know some patches were floating
> around to solve that... but I can't find them now. Any ideas?

Which framebuffer driver? Vesafb works for Timo, at least he did not
complain lately ;-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
