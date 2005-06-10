Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVFJNZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVFJNZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVFJNZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:25:29 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:34200
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261552AbVFJNYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:24:54 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Denis Vlasenko'" <vda@ilport.com.ua>, <abonilla@linuxwireless.org>,
       "'Pavel Machek'" <pavel@ucw.cz>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Netdev list'" <netdev@oss.sgi.com>,
       "'kernel list'" <linux-kernel@vger.kernel.org>,
       "'James P. Ketrenos'" <ipw2100-admin@linux.intel.com>
Subject: RE: ipw2100: firmware problem
Date: Fri, 10 Jun 2005 07:23:34 -0600
Message-ID: <000f01c56dbf$9b15de90$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200506100956.16031.vda@ilport.com.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Adding kernel level wireless autoconfiguration duplicates the effort.
> Since I am not going to give up a requirement to be able to stay radio
> silent at boot (me too wants freedom, not only you), you need to add
> disable=1 module parameter to each driver, which adds to the mess.
>
> ALSA does the Right Thing. Sound is completely muted out at
> module load.
> It's a user freedom to set desired volume level after that.

Yeah right. I remember I had to google for 10 minutes to find the answer for
this one. Why would you install something, for it to not work?

It thing of Mute in ALSA is stupid. If you want Sound, you install the Sound
and enable it. Why would it make you google for more things to do? ALSA mute
on install is WAY way, not OK.

You *will* have to use a How-To with ALSA, nobody knows that your sound
would be off because some people decided it.

But this is out of the Topic. I agree with you all, but as I mentioned in a
more current email, this is a laptop, not a server. Things behave
differently and you want things faster. (Yes, I could have a script)

What I'm saying, is that just as ALSA, you will have to google even more
just to be able to look for the boot param for the driver for it to ASSOC on
boot like the Original drive does. Instead, if you simply don't want to
associate then turn off the Radio.

It's a simple FN+F2 or depends on your laptop.

Let's not make this a bigger thread, just decide and then do it that way.
I'm looking at this on the side of a supporter, seeing the emails from
users... "how do I make it behave as it was before" "it won't assoc on boot
anymore"

.Alejandro

> --
> vda
>

