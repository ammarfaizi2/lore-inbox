Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbTAVWFp>; Wed, 22 Jan 2003 17:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbTAVWFp>; Wed, 22 Jan 2003 17:05:45 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7684 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264617AbTAVWFp>;
	Wed, 22 Jan 2003 17:05:45 -0500
Date: Wed, 22 Jan 2003 23:12:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Walrond <andrew@walrond.org>
Cc: Andy Grover <agrover@groveronline.com>, linux-kernel@vger.kernel.org,
       acpi-devel@sourceforge.net
Subject: Re: [PATCH] SMP parsing rewrite, phase 1
Message-ID: <20030122221256.GB14641@elf.ucw.cz>
References: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com> <3E2DAE2F.1070503@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2DAE2F.1070503@walrond.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Results from a an Asus PR-DLS Dual Xeon HT
> 
> Don't know if this is useful, but I'll try anything that might bring 
> back my e1000 ;) No joy though - doesn't find all the PCI buses (14 and 
> 18 missing - see below)
> 
> +==============================================================================+
> | CPU Type          : Intel(R) Xeon(TM) CPU 2.60GHz 
>        |
> | Cache Memory      : 512K,512K,512K,512K Memory Installed  : 4096M 
>        |
> +------------------------------------------------------------------------------+

Wow, this looks nice. DOes this mean you actually have bios able to
send messages over serial in PC-class machine? Wow!
							Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
