Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTA1OGB>; Tue, 28 Jan 2003 09:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbTA1OGB>; Tue, 28 Jan 2003 09:06:01 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:60048 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265446AbTA1OGA> convert rfc822-to-8bit;
	Tue, 28 Jan 2003 09:06:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Robert Morris <rob@r-morris.co.uk>
Subject: Re: Bootscreen
Date: Tue, 28 Jan 2003 15:15:15 +0100
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0301281149070.20509-100000@schubert.rdns.com>
In-Reply-To: <Pine.LNX.4.44.0301281149070.20509-100000@schubert.rdns.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301281515.15611.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I question the approach of automatically deciding to hide startup
> output from the user, in any case. I can imagine a set-top box user on the
> phone to the support department saying "it gets to the Starting - Please
> Wait screen, then just hangs", which would then require an engineer visit,
> as opposed to, for example, "it says Obtaining IP Address... then hangs"
> which would give the support techie the opportunity to tell the user to
> check the ethernet cable is plugged in correctly, etc, before resorting to
> sending out an engineer.

You'll never send an engineer out to replace a set-top-box. You'll just wait 
for the customer to return the box and send out a new one. Software doesn't 
fail on those - it's some 99.9% hardware failure. If you get a hang or panic 
or something, the boxes usually have watchdogs to take care of that (and then 
reboot automatically). The average computer-frightened user getting an STB 
from the VoD/IPTV company (or her ISP) don't want to see any kernel 
gibberish. They just want a nice splash screen telling them "everything's 
gonna be alright in 45 seconds" or something. Trouble shooting is done in the 
lab after the box is returned

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

