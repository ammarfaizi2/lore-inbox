Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUIVJw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUIVJw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 05:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUIVJw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 05:52:27 -0400
Received: from gprs214-135.eurotel.cz ([160.218.214.135]:58246 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263429AbUIVJw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 05:52:26 -0400
Date: Wed, 22 Sep 2004 11:48:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem with suspend and usb
Message-ID: <20040922094844.GA9197@elf.ucw.cz>
References: <1095685487.4294.14.camel@taz.graycell.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095685487.4294.14.camel@taz.graycell.biz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Tried suspend for the first time and after I booted with "nomce" (a
> workaround for my broken BIOS, I think) everything worked, apart from
> USB.
> When resuming, usb does not work. If I unload and load ohci_hcd module
> USB starts working again. My laptop is a Compaq Presario 920.
> Is it a known problem? 

Try latest -mm kernel.
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
