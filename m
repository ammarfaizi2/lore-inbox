Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbUC3N7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUC3N7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:59:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18624 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263661AbUC3N7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:59:38 -0500
Date: Tue, 30 Mar 2004 15:09:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/44] Support for scroll wheel on Office keyboards
Message-ID: <20040330130942.GC3084@openzaurus.ucw.cz>
References: <1079446776784@twilight.ucw.cz> <10794467761141@twilight.ucw.cz> <20040327195535.GA11610@wsdw14.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327195535.GA11610@wsdw14.win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Apart from this concrete question - the number of keyboards and
> mice is very large and growing by the day. I think it is hopeless
> to try and teach the kernel about all details of each of them.
> I think we should try to go for a keyboard/mouse definition file
> maintained in user space and fed to the kernel.

Well, if it can be maintained in userspace, it should be possible to maintain, too.
Plus it seems to me that some keyboards are compatible with others... for example arima
seems to generate same keycodes for "vol+" and "vol-" as compaq nx5000...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

