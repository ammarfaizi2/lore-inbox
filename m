Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277154AbRJDHlE>; Thu, 4 Oct 2001 03:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277153AbRJDHky>; Thu, 4 Oct 2001 03:40:54 -0400
Received: from tangens.hometree.net ([212.34.181.34]:62927 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S277111AbRJDHku>; Thu, 4 Oct 2001 03:40:50 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Date: Thu, 4 Oct 2001 07:41:18 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9ph3qu$g9b$1@forge.intermeta.de>
In-Reply-To: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca> <3BBC05EC.AA9BFB4F@candelatech.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1002181278 11723 212.34.181.4 (4 Oct 2001 07:41:18 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 4 Oct 2001 07:41:18 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

>jamal wrote:
>> 
>> I think you can save yourself a lot of pain today by going to a "better
>> driver"/hardware. Switch to a tulip based board; in particular one which
>> is based on the 21143 chipset. Compile in hardware traffic control and
>> save yourself some pain.

>The tulip driver only started working for my DLINK 4-port NIC
>after about 2.4.8, and last I checked the ZYNX 4-port still refuses
>to work, so I wouldn't consider it a paradigm of
>stability and grace quite yet.  Regardless of that, it is often
>impossible to trade NICS (think built-in 1U servers), and claiming
>to only work correctly on certain hardware (and potentially lock up
>hard on other hardware) is a pretty sorry state of affairs...

Does it finally do speed and duplex auto negotiation with Cisco
Catalyst Switches? Something I never ever got to work with various 2.0
and 2.2 drivers, mode settings, Catalyst settings, IOS versions and
almost anything else that I ever tried. 

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
