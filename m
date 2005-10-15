Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVJOHSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVJOHSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVJOHSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:18:14 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:25350 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751108AbVJOHSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:18:14 -0400
Message-ID: <4350AD0A.2010208@tuxrocks.com>
Date: Sat, 15 Oct 2005 01:17:30 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: LKML <linux-kernel@vger.kernel.org>,
       Steven Rostedt <rostedt@kihontech.com>,
       Con Kolivas <kernel@kolivas.org>,
       "high-res-timers-discourse@lists.sourceforge.net" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       john cooper <john.cooper@timesys.com>,
       George Anzinger <george@mvista.com>, Doug Niehaus <niehaus@ittc.ku.edu>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE] ktimers high resolution patches - clockevent	abstraction
 layer
References: <1129328040.1728.829.camel@tglx.tec.linutronix.de>
In-Reply-To: <1129328040.1728.829.camel@tglx.tec.linutronix.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas Gleixner wrote:
> i have released the 2.6.14-rc4-kthrt1 version of the high resolution
> timer enabled ktimers subsystem patch, which can be downloaded from

Great job.  I really like this rollup of ktimers + ktimersHRT + John's
TOD patches.

Initial results are showing excellent latency numbers.  I'll run some
tests overnight, and will report the results.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDUK0KaI0dwg4A47wRAg4JAKClGzgh0vGyt+yw0zoB5e3LoR82pwCfWgC7
L61GelaatdyczS8VbTKVWeQ=
=5Zb4
-----END PGP SIGNATURE-----
