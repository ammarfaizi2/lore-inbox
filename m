Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131462AbQLLPFU>; Tue, 12 Dec 2000 10:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbQLLPFK>; Tue, 12 Dec 2000 10:05:10 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:53892 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131462AbQLLPE7>; Tue, 12 Dec 2000 10:04:59 -0500
Date: Tue, 12 Dec 2000 09:34:30 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <3A3623C6.B2499D4D@haque.net>
Message-ID: <Pine.LNX.4.30.0012120929270.6172-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone gave me a really awesome idea about possibly using a palm pilot
to capture the oops. Anyone know if it will be a problem using
/dev/ttyUSB0 as the serial port?

Baiscally if I want to duplicate the environment in which I'm getting
the oops, I need to be dialed out. That takes out COM1. I never gt my
COM2 to work (can't figure out what's wrong. doesn't work under windows
either). So that's out. I have a Keyspan USB PDA adapter that I use for
my Palm Vx which shows up as /dev/ttyUSB0.

I guess if usb serial can't be used I'll try duplicating the oops w/o
being dialed out.

On Tue, 12 Dec 2000, Mohammad A. Haque wrote:

> What's the best way to capture (manually or otherwise) a rather long
> oops that scrolls off my console without having a second machine?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
