Return-Path: <linux-kernel-owner+w=401wt.eu-S1030430AbWLaS1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWLaS1k (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 13:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWLaS1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 13:27:40 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1556 "EHLO
	anchor-post-30.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030430AbWLaS1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 13:27:39 -0500
Date: Sun, 31 Dec 2006 18:23:42 +0000
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: linux-kernel@vger.kernel.org, drzeus-mmc@drzeus.cx,
       sdhci-devel@list.drzeus.cx
Subject: Re: [PATCH 2.6.20-rc2] Add a quirk to allow ENE PCI SD card readers to work again
Message-ID: <4E9DF97C12%ds@youmustbejoking.demon.co.uk>
References: <4E9DA5E8EB%linux@youmustbejoking.demon.co.uk> <4597A791.60007@drzeus.cx> <4E9DE7C297%linux@youmustbejoking.demon.co.uk> 
 <4E9DF295D4%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <4E9DF295D4%linux@youmustbejoking.demon.co.uk>
User-Agent: Messenger-Pro/4.14b7 (MsgServe/3.26b1) (RISC-OS/4.02) POPstar/2.06+cvs
Mail-Followup-To: linux@youmustbejoking.demon.co.uk,linux-kernel@vger.kernel.org,drzeus-mmc@drzeus.cx,sdhci-devel@list.drzeus.cx
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sun, 4870 Sep 1993 18:23:42 +0000
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I demand that I definitely did write...

> Add a quirk to allow ENE PCI SD card readers to work again

> Support for these devices was broken for 2.6.18-rc1 and later by commit
> 146ad66eac836c0b976c98f428d73e1f6a75270d, which added voltage level
> support.

> This restores the previous behaviour for these devices by ensuring that
> when the voltage is changed, only one write to set the voltage is
> performed.
[snip]

Oops, forgot to ask - could people test and report back? lspci output (for
your device) may be helpful.

-- 
| Darren Salt    | d @ youmustbejoking,demon,co,uk | nr. Ashington, | Toon
| RISC OS, Linux | s   zap,tartarus,org            | Northumberland | Army
| + Travel less. Share transport more.           PRODUCE LESS CARBON DIOXIDE.

regular guy: n. A person who occurs at fixed or pre-arranged intervals.
