Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWHPOnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWHPOnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHPOnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:43:09 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:2187 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1751186AbWHPOnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:43:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAEvM4kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Luke Sharkey <lukesharkey@hotmail.co.uk>
Subject: Re: Touchpad problems with latest kernels
Date: Wed, 16 Aug 2006 10:42:57 -0400
User-Agent: KMail/1.9.3
Cc: andi@rhlx01.fht-esslingen.de, davej@redhat.com, gene.heskett@verizon.net,
       ian.stirling@mauve.plus.com, linux-kernel@vger.kernel.org,
       malattia@linux.it, lista1@comhem.se
References: <BAY114-F135E5B07856A5191B7A119FA4C0@phx.gbl>
In-Reply-To: <BAY114-F135E5B07856A5191B7A119FA4C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161042.58005.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 09:59, Luke Sharkey wrote:
>   Seeing as Linux is less easily controlled with the keyboard compared to 
> MS-Windows,

Careful, you are threading dangerous waters here ;)

> sometimes all I can do is Alt-tab to the terminal window and do  
> a command line reboot.

> 
> (Off topic question: why not have the K menu open when the "MS-Windows" 
> button on the keyboard is pressed, as happens with the "Start" button on 
> MS-windows?)
> 

It doesn't? Indeed it does not! Alt-F1 does it though and it is much harder
to hid by accident (I can't count how many times I hit that key by accident
on windows box and then have to grab mouse to switch focus back to the window
that had it before). Anyway, it is indeed offtopic for kernel, try asking on
KDE lists...

> *However*, I have noticed that sometimes when I alt-tab between any windows 
> / programs I have open, sometimes the pointer becomes unstuck again...
> 
> >Also, is there programs that poll status of your battery or monitor box's 
> >temperature?
> 
> Battery charge level, yes, but not the box's temperature.  I have tried lots 
> of apps to try and do this, e.g. gkrellm, but there is no support for this 
> on my laptop.  Besides, these problems often evidence themselves soon after 
> I switch on, so I don't think laptop temperature would still be a problem 
> that early.  Also, I rip the occasional DVD, sometimes leaving my computer 
> on for 5+ hours: it doesn't overheat.
>

No, it is not overheating, just the act of polling battery status or
temperature may cause pointer stalls on some boxes.

-- 
Dmitry
