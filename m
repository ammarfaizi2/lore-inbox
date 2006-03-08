Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWCHLLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWCHLLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCHLLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:11:45 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:27097 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S1751313AbWCHLLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:11:44 -0500
Date: Wed, 08 Mar 2006 13:11:42 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [future of drivers?] a proposal for binary drivers.
In-reply-to: <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
To: Anshuman Gholap <anshu.pg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200603081311.42080.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
 <200603081151.33349.jk-lkml@sci.fi>
 <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 12:03, you wrote:

> allow 16k stack, install ndiswrapper and load the windows driver and
> compile install gtk-wifi app and get wifi network.  he might admit me
> into hospital for talk_while_geek with a normal person.

Yeah... and if manufacturers stopped being stubborn, and just made
it possible to create open-source drivers, all your friend would have
to do would be install the distro of his choice and it would all "just
work"... As it does currently with most ethernet cards. It just works.
Why? Because the drivers are opensource and in the kernel.

> I have thousands of similar scenarios. Even I wont mind the luxury of
> making hardware just working and not going to google>>download src>>if
> bug/error found>>go to forums post thread>>hang on irc and bug
> ppl>>get more things compiled done >>if work then enjoy>> or wait for
> the philanthropic coder to solve bug and release new ver.

I feel the pain too. I used to do this.

Eventually the binary drivers stepped on eachother's toes and exploded
spectaculary, and there was no fix to be found. I just gave up, and am now
using computer with mostly opensource drivers... Only item I haven't been
able to get away from so far is the dialup modem, which I have to use
binary drivers for... But I only use it in emergencies anyway, since the cost-free
drivers are only able to do 14.4kbit.

Actually, I'd be happy if the binary drivers actually MANAGED to get a 14.4K
connection... Anything above 2400bps seems futile. It's not the telephone line,
either, my old 33.6K modem worked reliably at 33600 constantly. Then thunder
struck and fried it :-(

The conexant softmodem was the only one available in the local store, and I
recalled there were binary drivers for it. Pity they don't work that well :(
The softmodem cost only 50E. A "real" modem is about 150E -250E or
something, and I don't want to spend that kind of money on something
that only gives me 56kbit...

I use my cellphone these days... It has horrendous latency, but atleast it
talks standard Hayes AT through its dataport.
