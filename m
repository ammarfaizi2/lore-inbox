Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTFXW0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTFXWZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:25:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6860 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263859AbTFXWY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:24:26 -0400
Subject: Re: Success stories, disappearing Oopses and ps/2 keyboard
From: john stultz <johnstul@us.ibm.com>
To: Konstantin Kletschke <konsti@ludenkalle.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030624164026.GA2934@sexmachine.doom>
References: <20030624164026.GA2934@sexmachine.doom>
Content-Type: text/plain
Organization: 
Message-Id: <1056493814.1032.253.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jun 2003 15:30:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 09:40, Konstantin Kletschke wrote:

> However, there is only one Problem left for me, before this one can be
> called 2.6.0: The keys on my PS/2 IBM Keyboard are bouncing very often!
> I switched from an USB Logitech Keyboard back to my old school, clicking
> PC-102 IBM Keyboard ATM and the Key bouncing was back immmediatly :(
> 
> Over ssh connections it is even more extreme, I don't know why.
> 
> Are there any approaches to debug or whatsoever that thing? I saw many
> changes to the input layer on this mailing list since 2.5.70 so I gave
> this one Kernel here another chance :) (see signature). I just wanted to
> say, the Problem hasn't gone yet, not more, and keep on hacking this
> great mastepiece of Kernel :-)

Could you further explain what you mean by key "bouncing"?
Do you mean the keyboard repeat rate is too fast? If so, could you let
me know more details about the system? Also could you try booting w/
"clock=pit" and let me know if the problem persists?

thanks
-john


