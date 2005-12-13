Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVLMWD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVLMWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVLMWD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:03:58 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:4690 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030255AbVLMWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:03:58 -0500
From: David Brownell <david-b@pacbell.net>
To: Anderson Lizardo <anderson.lizardo@indt.org.br>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Tue, 13 Dec 2005 14:03:53 -0800
User-Agent: KMail/1.7.1
Cc: linux-omap-open-source@linux.omap.com,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
References: <20051213213208.303580000@localhost.localdomain>
In-Reply-To: <20051213213208.303580000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131403.53983.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, cool ... glad to see that's ready now!
I'll have to give it a try when I have a spare moment.

Is there a writeup on how to hook this up with the key retention
infrastructure?  I know many folk are unfamiliar with that, and
I seem to recall a need for some userspace tweaks.  (Like SHA1
hashing of passphrases to generate MMC keys, and maybe storing
keys in some per-user file using some user interface.)

- Dave

