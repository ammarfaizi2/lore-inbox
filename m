Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319389AbSIFUxm>; Fri, 6 Sep 2002 16:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319393AbSIFUxb>; Fri, 6 Sep 2002 16:53:31 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8320 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319389AbSIFUwM>;
	Fri, 6 Sep 2002 16:52:12 -0400
Date: Fri, 6 Sep 2002 10:28:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: venom@sns.it, ahu@ds9a.nl, linux-kernel@vger.kernel.org
Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
Message-ID: <20020906102849.A35@toy.ucw.cz>
References: <20020905153709.29686.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020905153709.29686.qmail@linuxmail.org>; from ciarrocchi@linuxmail.org on Thu, Sep 05, 2002 at 11:37:09PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I usually run byte bench regularly with every new kernel, so I see some
> > strange results here.
> > 
> > From your numbers, I would say you are using a PIII 600/900 Mhz (more or
> > less). It is not an AMD AThlon or a PIV, since float and double are too
> > slow, not it is a K6 because they are too fast.
> Yes, I ran the test on a HP Omnibook 600 (PIII@900)

APM or ACPI? How did you guarantee not going powersave?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

