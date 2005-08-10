Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVHJKDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVHJKDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHJKDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:03:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31619 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932555AbVHJKDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:03:40 -0400
Date: Wed, 10 Aug 2005 12:03:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: PowerOP 3/3: Intel Centrino cpufreq integration
Message-ID: <20050810100339.GB1945@elf.ucw.cz>
References: <20050809025727.GD25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809025727.GD25064@slurryseal.ddns.mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A minimal example of modifying cpufreq to use PowerOP for reading and
> writing power parameters on Intel Centrino platforms.  It would be
> possible to move voltage table lookups to the PowerOP layer.

Aha, ok, sorry for my previous comment. It looks like powerop
framework can cleanup speedstep-centrino a tiny bit. Where else is it
used?

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
