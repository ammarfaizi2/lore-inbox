Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTBPKmG>; Sun, 16 Feb 2003 05:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbTBPKmF>; Sun, 16 Feb 2003 05:42:05 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8964 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266285AbTBPKmC>;
	Sun, 16 Feb 2003 05:42:02 -0500
Date: Sat, 15 Feb 2003 23:35:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bernhard Kaindl <bernhard.kaindl@gmx.de>
Cc: linux-kernel@vger.kernel.org, Bernhard Kaindl <bk@suse.de>
Subject: Re: Had ICH3 DMA engine for AC'97 modem codec running
Message-ID: <20030215223508.GC210@elf.ucw.cz>
References: <Pine.LNX.4.53.0302142104030.4829@hase.a11.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0302142104030.4829@hase.a11.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Also note that V34 and faster codecs are patented. It's not
> allowed to write code for these you have a licence. Maybe
> it's enough to have such modem, I just want to say that
> this is just for fun and not to use it as modem.

As long as you are in Europe, you are okay. And V.34 is pretty
difficult to write, anyway. [There's implementation of most of v.34 in
assembler for some TI DSP, somewhere, but it misses echo cancelling
and setup protocol].
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
