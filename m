Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132854AbRDIVeX>; Mon, 9 Apr 2001 17:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132855AbRDIVeN>; Mon, 9 Apr 2001 17:34:13 -0400
Received: from tangens.hometree.net ([212.34.181.34]:46802 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S132854AbRDIVeG>; Mon, 9 Apr 2001 17:34:06 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [OT] Re: goodbye
Date: Mon, 9 Apr 2001 21:34:04 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9at9sc$kva$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.21.0104031800030.14090-100000@imladris.rielhome.conectiva> <986844003.21377.12.camel@mistress>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 986852044 8774 212.34.181.4 (9 Apr 2001 21:34:04 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 9 Apr 2001 21:34:04 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Peddemors <michael@linuxmagic.com> writes:

>Uh... use their ISP relay service anyway???
>I take my laptop all over, to lot's of my clients locations, and if I
>could relay through their servers, then I had better give them some good
>advice.. Some places I just pick an available IP and it might not be in
>the allowed relay list.  And this happens when I am in M$ or Linux..

So, Mr. Admin, setup your laptop to use SSL to your SMTP and POP
server and authenticate with a client side certificate on your
laptop. Welcome to the 21st century. You may, however, need a little
more infrastructure than you can pull from your favourite distribution
box.

>And sometimes, I even go to locations where they can't tell me their
>ISP's SMTP mailer.. Not to mention, I shouln't have to reset my
>configuration for each location I happen to be at..
>The point is, if it is a pain, then people will be less likely to
>contribute..

So you made something wrong. My servers have public IP addresses.
Wherever I am on the Internet, I can connect to them. I can
authenticate myself as being me, and they accept my mails. No problem
here. No reconfiguration, either.

Come on people, stop whining. If everybody here is using mobile clients and
different locations for mail sending and receiving, you should either

- get a hosted or housed box with your own mail server
- use a commercial web or POP/SMTP mail service
- get an ISP which does have a clue and its mail server not in ORBS or RBL
  (they may, however not be the cheapest around)

or (as mentioned above), set up a box with TLS, relay from everywhere
and their neigbor with authentication to this box and then go out via
a well known SMTP server into the internet.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
