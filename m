Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTLSHA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 02:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTLSHA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 02:00:58 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:29652 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261411AbTLSHAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 02:00:54 -0500
Date: Thu, 18 Dec 2003 23:00:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: szonyi calin <caszonyi@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.6.0
Message-ID: <27340000.1071817249@[10.10.2.4]>
In-Reply-To: <20031219013810.20470.qmail@web40610.mail.yahoo.com>
References: <20031219013810.20470.qmail@web40610.mail.yahoo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was writing a cd (with ide-atapi) and downloading something 
> on dial-up and when i switched desks (screens) in fvwm a 
> hard lockup occured (X froze, dial up link froze (the leds on
>  the modem didn't blinked anymore) and i could't use alt + SysRQ
> also). I had to press the reset button :-(

if Alt+Sysrq doesn't work, you might want to setup NMI watchdog,
and see if that gives you anything ...

M.

