Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbULBULR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbULBULR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbULBULQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:11:16 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:1159 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261745AbULBULO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:11:14 -0500
Message-ID: <41AF76E0.5050907@tomt.net>
Date: Thu, 02 Dec 2004 21:11:12 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
References: <20041201104820.1.patchmail@tglx>	 <20041201211638.GB4530@dualathlon.random>	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>	 <20041202033619.GA32635@dualathlon.random>	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>	 <20041202164725.GB32635@dualathlon.random>	 <20041202085518.58e0e8eb.akpm@osdl.org>	 <20041202180823.GD32635@dualathlon.random>	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>	 <20041202110729.57deaf02.akpm@osdl.org>	 <1102014493.13353.239.camel@tglx.tec.linutronix.de>	 <20041202112208.34150647.akpm@osdl.org> <1102015450.13353.245.camel@tglx.tec.linutronix.de>
In-Reply-To: <1102015450.13353.245.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Thu, 2004-12-02 at 11:22 -0800, Andrew Morton wrote:
>>You can issue sysrq commands over serial consoles too.
> 
> I know, but the console and the reset button are 150km away. When I dial
> into the machine or try to connect via the network, I cannot connect
> with the current kernels. Neither 2.4, because the fork fails, nor 2.6
> because oom killed sshd. So I cannot send anything except a service man,
> who drives 150km to hit sysrq-F or the reset button.

Get one of those terminal server/concentrators that export the serial 
consoles over IP. Or one of those KVM-over-IP extenders. Worth every penny.

[sorry thomas, forgot reply all first time aound, so you'll get a dupe.]
