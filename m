Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbVG3TnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbVG3TnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVG3Tmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:42:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16805 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263133AbVG3TmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:42:22 -0400
Date: Sat, 30 Jul 2005 21:42:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brian Schau <brian@schau.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
Message-ID: <20050730194215.GA9188@elf.ucw.cz>
References: <42EB940E.5000008@schau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EB940E.5000008@schau.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've attached a gzipped version of my Wireless Security Lock patch
> for v2.6.13-rc4.
> A Wireless Security Lock (WSL or weasel :-) is made up of two parts.
> One part is a receiver which you plug into any available USB port.
> The other part is a transmitter which at fixed intervals sends
> "ping packets".
> A "ping packet" usually consists of an ID and a flag telling if the
> transmitter has just been turned on.

Idea is good... but why don't you simply use bluetooth (built into
many notebooks) and bluetooth-enabled phone?

Probably could be done in userspace, too :-).
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
