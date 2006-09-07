Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWIGWOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWIGWOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWIGWOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:14:24 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:28690 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751909AbWIGWOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:14:23 -0400
Date: Thu, 07 Sep 2006 21:33:53 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: dtor@insightbb.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Touchpad sometimes detected twice
Message-ID: <4E62CC4533%linux@youmustbejoking.demon.co.uk>
References: <4E623F81FD%linux@youmustbejoking.demon.co.uk> <200609062216.30904.dtor@insightbb.com>
In-Reply-To: <200609062216.30904.dtor@insightbb.com>
User-Agent: Messenger-Pro/4.12 (MsgServe/3.25) (RISC-OS/4.02) POPstar/2.06+cvs
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Thu, 4755 Sep 1993 21:33:53 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I demand that Dmitry Torokhov may or may not have written...

> On Wednesday 06 September 2006 14:56, Darren Salt wrote:
>> Sometimes, the touchpad on my (new) laptop is detected twice. This can
>> cause problems with udev: there may or may not be links in
>> /dev/input/by-*, and if present, the links may be broken.

>> Config etc. attached.

> Hmm, you could try booting with i8042.nomux.

Now tried, and added to the boot command line; so far, the problem hasn't
reappeared.

> Does this laptop have external PS/2 ports?

No.

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + At least 4000 million too many people. POPULATION LEVEL IS UNSUSTAINABLE.

Your most useful program will be continually improved until it is useless.
