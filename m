Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWA1QgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWA1QgR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWA1QgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:36:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7901 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751471AbWA1QgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:36:16 -0500
Date: Sat, 28 Jan 2006 17:36:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Luca <kronos@kronoz.cjb.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060128163611.GB1858@elf.ucw.cz>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127232207.GB1617@elf.ucw.cz> <20060128155800.GA3064@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128155800.GA3064@dreamland.darkstar.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If vbetool's primary purpose is to fix video after suspend/resume,
> > then perhaps right thing to do is to integrate it into s2ram and
> > maintain it there.
> > 
> > Matthew, what do you think?
> > 
> > Luca, would you cook quick&hacky fork-and-exec patch? I do not have
> > machine that needs vbetool...
> 
> Very quick and very hacky ;)

Thanks; applied after some cleanups. Could you fetch it from cvs and
confirm it still works?
								Pavel
-- 
Thanks, Sharp!
