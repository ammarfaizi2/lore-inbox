Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264446AbTCXWBk>; Mon, 24 Mar 2003 17:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264454AbTCXWBj>; Mon, 24 Mar 2003 17:01:39 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264446AbTCXWBC>;
	Mon, 24 Mar 2003 17:01:02 -0500
Date: Tue, 25 Mar 2003 10:35:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
Message-ID: <20030325093550.GD1083@zaurus.ucw.cz>
References: <10482950873871@kroah.com> <10482950921680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10482950921680@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +	.name		= "ADM1021-MAX1617",

Why dash here

> +	.name		= "LM75 sensor",

And space here? Also you should have 
either 2x "sensor" or none at all. 
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

