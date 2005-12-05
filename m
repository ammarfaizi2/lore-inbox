Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVLELfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVLELfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 06:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVLELfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 06:35:47 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:50646 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932348AbVLELfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 06:35:46 -0500
Message-ID: <4394260F.7020703@anagramm.de>
Date: Mon, 05 Dec 2005 12:35:43 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
CC: linux-kernel@vger.kernel.org, Jeff Collins <jgcc@pacbell.net>
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
References: <433A747E.3070705@anagramm.de>
In-Reply-To: <433A747E.3070705@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Guys, hello, Jeff!

This issue seems to happen more than once:

Jeff Collins wrote:
> I experience a panic whenever I shut down a 4 cpu Intel PII Xeon SMP 
> system.

What panic do you get?

> Linux sitka 2.6.14.3 #2 SMP Fri Dec 2 09:01:46 PST 2005 i686 unknown 
> unknown GNU/Linux
> Base OS: Slackware 10.2
> Kernel: 2.6.14.3 from kernel.org
> 
> "shutdown -h now" causes the panic
> 
> "shutdown -r now" reboots correctly.

I guess it panics, too, but the reboot still works, so you just don't
see the panic. (?)

> I got the same panic when I substituted the 2.6.13 kernel.

Still the same thing over here. Unfortunately, I am pretty busy with other
work, and the affected system isn't really needed. It's an old
Tyan Tomcat IIID Mainboard with two Pentium I MMX 200MHz CPU's.
Theoretically I would be able to test the latest git snapshots, but currently
it's just not possible. :-(
Let me know if you cannot solve this issue - maybe I can spend some
time to give some more information for debugging by the end of this week.

Good Luck,

Best greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
