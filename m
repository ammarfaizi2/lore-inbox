Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVALWuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVALWuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVALWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:48:31 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:32991 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261520AbVALWoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:44:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.10][Suspend] - Time problems
Date: Wed, 12 Jan 2005 23:44:11 +0100
User-Agent: KMail/1.7.1
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
References: <200501110235.37039.shawn.starr@rogers.com> <20050112222400.GA2139@elf.ucw.cz>
In-Reply-To: <20050112222400.GA2139@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501122344.11508.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 12 of January 2005 23:24, Pavel Machek wrote:
> Hi!
> 
> > When resuming from suspend, I noticed the clock is waay off (its 10:16pm, 
it 
> > shows 2:34AM EST time). This is even after a reboot the bios now shows 
wrong 
> > time?
> 
> Yes, see for example thread "2.6.10-mm2: swsusp regression
> [update]". Nigel has some patch that should fix it...

Do you mean patches in the "[RFC] Patches to reduce delay in 
arch/kernel/time.c" thread?

RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
