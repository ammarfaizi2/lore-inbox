Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVG3VSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVG3VSy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVG3VQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:16:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22242 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262884AbVG3VQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:16:42 -0400
Date: Sat, 30 Jul 2005 23:16:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brian Schau <brian@schau.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
Message-ID: <20050730211636.GD9418@elf.ucw.cz>
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz> <42EBDEA9.60505@schau.com> <20050730203159.GB9418@elf.ucw.cz> <42EBEDB1.7020802@schau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EBEDB1.7020802@schau.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I (and others) have tried using combinations of libusb/userland
> stuff - but have failed miserably.

You may need to patch input to keep hands off that device, but the
rest should be doable using libusb, right? Or talk to vojtech, using
input devices should devices without libusb should be possible too. 

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
