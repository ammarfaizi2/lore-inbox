Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVKIOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVKIOdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVKIOdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:33:38 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:20192 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751360AbVKIOdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:33:37 -0500
References: <20051109135925.GF12751@localhost.localdomain>
In-Reply-To: <20051109135925.GF12751@localhost.localdomain>
From: hunold@linuxtv.org
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: linux-kernel@vger.kernel.org,
       "linux-dvb@linuxtv.org" <linux-dvb@linuxtv.org>
Subject: Re: [linux-dvb-maintainer] Multiple USB DVB devices cause hard
  lockups
Date: Wed, 09 Nov 2005 15:33:27 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <E1EZr0x-0005dY-7o@allen.werkleitz.de>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Scanned: No (on allen.werkleitz.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hugo, 

Hugo Mills writes:
>    I'm trying to get a pair of Twinhan Alpha II DVB-USB devices
> working on the same machine. With a single device plugged in, I can
> quite easily receive and stream data. 
> 
>    With both devices connected to the machine, both are recognised.
> However, use of either device causes some form of stack backtrace (I
> can't see the top of it to verify what kind) from the kernel, and a
> hard lock-up. Magic SysRQ is non-functional after the lock-up. Failure
> cases that I've seen are:

Thank you for your report. I forwarded the mail to the linux-dvb mailing 
list. Hopefully somebody is able to help you. 

Please consider subscribing to the linux-dvb mailing list:
http://www.linuxtv.org/cgi-bin/mailman/listinfo 

>    Hugo.

CU
Michael. 

