Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTIBHMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTIBHL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:11:59 -0400
Received: from [212.34.184.41] ([212.34.184.41]:32429 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id S263588AbTIBHL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:11:58 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: bandwidth for bkbits.net (good news)
Date: Tue, 2 Sep 2003 07:11:38 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bj1fra$its$5@tangens.hometree.net>
References: <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1062486698 19388 212.34.184.4 (2 Sep 2003 07:11:38 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 2 Sep 2003 07:11:38 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

>> They are Cisco configuration, it won't do you much good.  All the traffic

>I don't trust anything but the sourcecode I can read, so please try
>again with linux.

Andrea, you have no clue at all. Please stop this. You might be
terrific at VM and linux kernel internals but you suck at network
topology and serious internet traffic routing.

You want to try rate limiting a DDoS attack from the wrong side of a
small pipe. You can't do this. Not with Linux, with BSD, with a C64 or
a Cisco. 

People have been trying this on the internet since 1995 and know what
they're talking about. This is not a case of "I have no clue, so I
didn't know that it was impossible and I did it". There are people out
there that got Ph.D.'s for proving that it's impossible to do what you
suggest and other people that got rich building devices that can do
this (from the right end of the pipe).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)
