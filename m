Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWGLA6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWGLA6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWGLA6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:58:03 -0400
Received: from terminus.zytor.com ([192.83.249.54]:31418 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932332AbWGLA6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:58:00 -0400
Message-ID: <44B448F6.5060508@zytor.com>
Date: Tue, 11 Jul 2006 17:57:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net
Subject: Re: Will there be Intel Wireless 3945ABG support?
References: <1152635563.4f13f77cjsmidt@byu.edu> <20060711171238.GA26186@tuxdriver.com> <200607111909.22972.s0348365@sms.ed.ac.uk> <44B3ED29.4040801@gmail.com> <20060711201615.GB11871@Marvin.DL8BCU.ampr.org> <20060712004212.GA26712@phoenix>
In-Reply-To: <20060712004212.GA26712@phoenix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Tuttle wrote:
> 
> Frankly, I think Intel is misinterpreting how strict the FCC is being
> (or maybe the FCC is being too strict).  I would interpret their
> mandates as meaning that, as purchased, equipment can't transmit on
> unauthorized frequencies, and that it's not "user-modifiable".  User
> modification doesn't include things like opening the case of a toy
> walkie-talkie up and swapping out a crystal, nor does it include things
> like opening up the firmware or driver for something and messing with
> it.
> 

Unfortunately you're wrong.  Some manufacturers have gotten rapped for 
marketing equipment that can be modded by stuff like desoldering diodes.

The FCC has some incredibly heavy-weight regulations, like:

- Problem: unlicensed high-power CB operation
- Solution: ban amplifiers that work anywhere near the CB band, 
including several amateur radio bands (even for sale to users with valid 
amateur licenses)

- Problem: unencrypted cell phones
- Solutions: ban scanners that work on the cell phone bands

... etc ...

	-hpa
