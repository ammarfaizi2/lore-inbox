Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268649AbTCCWFu>; Mon, 3 Mar 2003 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268650AbTCCWFu>; Mon, 3 Mar 2003 17:05:50 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6660 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268649AbTCCWFt>;
	Mon, 3 Mar 2003 17:05:49 -0500
Date: Mon, 3 Mar 2003 22:57:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <20030303215728.GB230@elf.ucw.cz>
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme> <447430000.1046473881@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447430000.1046473881@flay>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +Oprofile
> +--------
> +get source (I use 0.5) from http://oprofile.sourceforge.net/
> +add "poll=idle" to the kernel command line 

This should be idle=poll, AFAICS.
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
