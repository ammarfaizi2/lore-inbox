Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTEKR15 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEKR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:27:57 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:9858 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261786AbTEKR15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:27:57 -0400
Date: Sun, 11 May 2003 19:38:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Damian =?utf-8?Q?Ko=C5=82kowski?= <deimos@deimos.one.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Message-ID: <20030511173817.GA2155@elf.ucw.cz>
References: <20030509113358.GA14798@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509113358.GA14798@deimos.one.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'am wondering why setfont and loadkeys in setting only on first tty.
> It works (setting font map on all six tty) in 2.{2,4}.x.
> 
> I'am using _radeonfb_ with rv250if, could it be the reason?

FYI, its same as vesafb here.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
