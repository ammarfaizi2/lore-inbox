Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTAEWgo>; Sun, 5 Jan 2003 17:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTAEWgo>; Sun, 5 Jan 2003 17:36:44 -0500
Received: from mail.hometree.net ([212.34.181.120]:17815 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265339AbTAEWgn>; Sun, 5 Jan 2003 17:36:43 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Why is Nvidia given GPL'd code to use in non-free drivers?
Date: Sun, 5 Jan 2003 22:45:18 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <avachu$gnf$1@forge.intermeta.de>
References: <20030102013736.GA2708@gnuppy.monkey.org> <1041806677.15071.8.camel@irongate.swansea.linux.org.uk>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1041806718 27307 212.34.181.4 (5 Jan 2003 22:45:18 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 5 Jan 2003 22:45:18 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>WLAN yes - openap is superb stuff

I didn't mention an open source access point. I already have a tried
and true one in hardware from Lucent. I meant a "driver which doesn't
lock up if it meets the WLAN card in an unusual configuration like
say, on an PCI/PCMCIA bridge in a desktop computer (yes, Windows 2000
screwed this one up, too. But they managed to fix it in SP1).

Or really supports all of the 802.11b power management modes if the
card is in managed mode (the WLAN card in my lap top sucks tremendous
amounts of current even if I don't do any data transfers. Under
windows the card goes to sleep and needs about 5% of the power). And
yes, the access point knows how to manage the card. =:-) That was the
whole point of buying an (start-1999) $1200 access point.

>DHCP - yes

Point taken. The ISC code seems to be the standards implementation.

>ACPI - very recently become a truely open project so will I hope now
>improve

"very recently". :-)

>APM - reliable for years, bios code (the nonfree bit) often very buggy

The APM code on my Laptop still can't figure out how to display the
battery level correctly all the time (it flips to "0%" for a few
seconds every five to ten minutes), so I can't use the "shut down if
below 5%" feature of apmd or my lap top would start shutting down
every five to ten minutes. Needless to tell that the Windows 2000 APM
has no such problem. BIOS? Really? (BTW: This is an Acer 710TE, one of
the best documented Linux laptops on the net). The buttons for
controlling the brilliance and contrast of the screen work fine in
console mode but not in X11. But the Func+F<n> buttons don't work at
all, because Linux considers "Func" the same as "ALT" (it is
not). Only if I don't have a virtual console on the F<n> key, it
works. It does work in console mode, though.

Yes, I know, I can map all this to work correctly with X11 key
mappings and I actually do know how to do it. But then again, I have
21+ years of computing experience, starting with self-soldered 8085
boards. My wife e.g. does not. 

The point is: With Linux I must (I can!) do all of this for myself.
For my wife, Windows 2000 does all the grunt work. So she uses Win2k a
nd I use Linux (but I have to support the Win2k for her. :-) After all 
she's not a CS major).

>> If you find a well designed and completely specified and developed
>> piece of open source software, you're almost sure to find a company or
>> an individual having been paid for developing it and the putting it
>> into open source.

>I don't think its that clear. We have some extremely classy code done
>for fun, or because people had the hardware, and some horrible code
>people were paid to write.

>Good code is about good engineers, and good engineers do things for many
>different reasons and motivations. 

You're definitely right. I tried to polarize a little. :-) 

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
