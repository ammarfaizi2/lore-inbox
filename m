Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbULPB6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbULPB6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbULPBy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:54:28 -0500
Received: from gprs215-43.eurotel.cz ([160.218.215.43]:45442 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262615AbULPBCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:02:03 -0500
Date: Thu, 16 Dec 2004 02:01:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Park Lee <parklee_sel@yahoo.com>
Cc: dave@lafn.org, linux-kernel@vger.kernel.org
Subject: Re: Issue on connect 2 modems with a single phone line
Message-ID: <20041216010138.GC6285@elf.ucw.cz>
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215184206.43601.qmail@web51505.mail.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   I want to try serial console in order to see the
> complete Linux kernel oops. 
>   I have 2 computers, one is a PC, and the other is a
> Laptop. Unfortunately,my Laptop doesn't have a serial
> port on it. But then, the each machine has a internal
> serial modem respectively.
>   Then, can I use a telephone line to directly connect
> the two machines via their internal modems (i.e. One
> end of the telephone line is plugged into The PC's
> modem, and the other end is plugged into The Laptop's
> modem directly), and let them do the same function as
> two serial ports and a null modem can do? If it is,
> How to achieve that?

You'd need phone exchange to do this. Most modems will not talk using
simple cable. With 12V power supply and resistor phone exchange is
quite easy to emulate, but...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
