Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTKGWmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKGW0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5533 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264347AbTKGN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 08:56:07 -0500
Date: Fri, 7 Nov 2003 14:56:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: test9: suspend no go
Message-ID: <20031107135605.GF20585@atrey.karlin.mff.cuni.cz>
References: <3F9BCF7A.7000403@portrix.net> <20031107100609.GA5088@elf.ucw.cz> <3FAB8CA1.7040105@portrix.net> <20031107132146.GC20585@atrey.karlin.mff.cuni.cz> <3FABA030.9040405@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FABA030.9040405@portrix.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> |>Any idea, why the laptop is not powering on again after suspend? I can
> |>hold down the power switch as long as I want to, but the laptop doesn't
> |>do a thing.
> |
> |
> | Seems like hardware bug? [So you have to remove battery/AC then
> | poweron?]
> | 								Pavel
> 
> Exactly. Pretty annoying. In those days where Windows XP powered the
> laptop, this worked, so I'm pretty sure it is no hardware bug. If I
> press the power switch, the power & disk light goes on, but nothing happens.
> Is there anything w/ acpi I can try?

Hacking lowlevel sleep functions, maybe. Not sure about l-k status.

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
