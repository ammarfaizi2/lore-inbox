Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVDEOOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVDEOOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVDEOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:12:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31709 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261756AbVDEOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:12:00 -0400
Date: Sat, 2 Apr 2005 10:59:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Schweizer <sschweizer@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Norbert Preining <preining@logic.at>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050402085935.GC1330@openzaurus.ucw.cz>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <e79639220504010938582bade6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79639220504010938582bade6@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Same issue here.
> 
> Suspend-to-ram works perfectly fine with kernel 2.6.12-rc1-mm1, in
> mm2,3 and mm4 it is broken.
> 
> It suspends properly but does not resume. Just a blackscreen and no
> reaction on keypress/usb plug-in/network/power button.
> 

Same way to debug it, then.... try minimal drivers.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

