Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbTIHNZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTIHNYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51421 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262280AbTIHNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:03 -0400
Date: Wed, 3 Sep 2003 15:41:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [Fwd: Re: via rhine network failure on 2.6.0-test4]
Message-ID: <20030903134142.GO1358@openzaurus.ucw.cz>
References: <3F4A2D35.4090307@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4A2D35.4090307@austin.rr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Handle 0x0004
>    DMI type 4, 32 bytes.
>    Processor Information
>        Socket Designation: Socket A
>        Type: Central Processor
>        Family: Duron
>        Manufacturer: AMD
>        ID: 62 06 00 00 FF F9 83 03
>        Signature: Type 0, Family 6, Model 6, Stepping 2
>        Flags:
...
>        Version: AMD Athlon(tm) XP
>        Voltage: 3.3 V
>        External Clock: 133 MHz
>        Max Speed: 1500 MHz
>        Current Speed: 1600 MHz

Hmm, your cpu is running at 106% :-).

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

