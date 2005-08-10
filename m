Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVHJKBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVHJKBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVHJKBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:01:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30339 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932555AbVHJKBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:01:54 -0400
Date: Wed, 10 Aug 2005 12:01:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: PowerOP 2/3: Intel Centrino support
Message-ID: <20050810100133.GA1945@elf.ucw.cz>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Minimal PowerOP support for Intel Enhanced Speedstep "Centrino"
> notebooks.  These systems run at an operating point comprised of a cpu
> frequency and a core voltage.  The voltage could be set from the values
> recommended in the datasheets if left unspecified (-1) in the operating
> point, as cpufreq does.

Eh? I thought these are handled okay by cpufreq already? What is
advantage of this over cpufreq?
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
