Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWF2TBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWF2TBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWF2TBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:01:16 -0400
Received: from mail.timesys.com ([65.117.135.102]:46990 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932168AbWF2TBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:01:14 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ -V4
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
In-Reply-To: <20060629174838.GA1695@elf.ucw.cz>
References: <1150747581.29299.75.camel@localhost.localdomain>
	 <20060629174838.GA1695@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 21:03:16 +0200
Message-Id: <1151607796.25491.677.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

On Thu, 2006-06-29 at 19:48 +0200, Pavel Machek wrote:
> I briefly tested -dyntick5 on my thinkpad, and it seems to work
> okay... but timer still seems to tick at 250Hz.

> ...am I doing something wrong?

can you send me the bootlog and your .config file please ?

	tglx


