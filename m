Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVGaWfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVGaWfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGaWdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:33:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28060 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261586AbVGaWcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:32:53 -0400
Date: Mon, 1 Aug 2005 00:32:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Bruce <bruce@andrew.cmu.edu>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050731223247.GA27580@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <1122846092.13000.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122846092.13000.4.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [But we
> > probably want to enable ACPI and cpufreq by default, because that
> > matches what 99% of users will use.]
> 
> Sorry, this is just ridiculous.  You're saying 99% of Linux
> installations are laptops?  Bullshit.

No, I'm saying that 99% users enable ACPI and cpufreq. ACPI is needed
on new machines, and cpufreq is usefull to keep your desktop cold,
too.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
