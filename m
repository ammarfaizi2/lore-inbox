Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268981AbTBZWWl>; Wed, 26 Feb 2003 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbTBZWVN>; Wed, 26 Feb 2003 17:21:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:5124 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268960AbTBZWUz>;
	Wed, 26 Feb 2003 17:20:55 -0500
Date: Wed, 26 Feb 2003 22:22:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>, alan@redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 407] New: Keyboard glitch detected, ignoring keypress
Message-ID: <20030226212256.GD346@elf.ucw.cz>
References: <9830000.1046224504@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9830000.1046224504@flay>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> http://bugme.osdl.org/show_bug.cgi?id=407
> 
>            Summary: Keyboard glitch detected, ignoring keypress
>     Kernel Version: 2.5.62-ac1
>             Status: NEW
>           Severity: normal
>              Owner: alan@lxorguk.ukuu.org.uk
>          Submitter: storri@sbcglobal.net

Alan, please kill that toshiba patch from 2.5.X. 2.5.X has soft
autorepeat, so it should no longer matter. I'm not using that machine
enough to see if it is really the case, but I trust vojtech.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
