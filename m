Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUCMUrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 15:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbUCMUrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 15:47:32 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:26586 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S263185AbUCMUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 15:47:07 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
Date: Sat, 13 Mar 2004 17:47:03 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Rick Knight <rick_knight@rlknight.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel 536EP Modem
In-Reply-To: <40536865.5010008@rlknight.com>
Message-ID: <Pine.LNX.4.58.0403131739450.8351@pervalidus.dyndns.org>
References: <40536865.5010008@rlknight.com>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a winmodem, so this is off topic here. What you see in the
sources are things to identify it with lspci etc, not to make
it work.

Check
http://developer.intel.com/design/modems/support/drivers.htm .
Unfortunately, you get what you pay for. I own such a crap (as
a backup, because I have ADSL), actually, the 537, and Intel
doesn't even list drivers for my model (only for the 537EP),
but I could get them at
http://linmodems.technion.ac.il/packages/Intel/537/ . And yes,
there's no 2.6 support, another reason to stay away from such
winmodems.

On Sat, 13 Mar 2004, Rick Knight wrote:

> I have an Intel 536EP modem I would like to be able to use with linux. I
> have kernel 2.6.3 installed. I notice that the  modem is detected by the
> system and several files in the kernel source tree have make reference
> to it...
>
> Is it possible to get this modem to work?

-- 
http://www.pervalidus.net/contact.html
