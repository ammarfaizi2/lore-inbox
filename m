Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVFVLFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVFVLFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVFVLFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:05:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7047 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261931AbVFVLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:05:27 -0400
Date: Wed, 22 Jun 2005 12:49:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Message-ID: <20050622104927.GB2561@openzaurus.ucw.cz>
References: <007301c575d9_77decb90_600cc60a@amer.sykes.com> <1119303358.17380.0.camel@mindpipe> <42B73BB7.4030906@linuxwireless.org> <1119310501.17602.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119310501.17602.1.camel@mindpipe>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm trying to do watch -n1 cat /proc/acpi/ibm/ecdump, But I don't have 
> > ecdump. I'm with ibm-acpi 0.8
> > 
> 
> I was thinking more along the lines of figure out the io port it's
> using, then boot windows, set an IO breakpoint in softice, then drop
> your laptop on the bed or something.

It should be enough to tilt your laptop so that it parks heads... safer than
dropping it.

And perhaps easier solution is to locate the sensor on the mainboard, and
trace where it is connected with magnifying glass (as vojtech already suggested).

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

