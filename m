Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265365AbSJXJcf>; Thu, 24 Oct 2002 05:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265366AbSJXJcf>; Thu, 24 Oct 2002 05:32:35 -0400
Received: from mail.hometree.net ([212.34.181.120]:1987 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265365AbSJXJce>; Thu, 24 Oct 2002 05:32:34 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: One for the Security Guru's
Date: Thu, 24 Oct 2002 09:38:46 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap8f36$8ge$1@forge.intermeta.de>
References: <Pine.LNX.3.95.1021023105535.13301A-100000@chaos.analogic.com> <Pine.LNX.4.44.0210231346500.26808-100000@innerfire.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035452326 14906 212.34.181.4 (24 Oct 2002 09:38:46 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 24 Oct 2002 09:38:46 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack <gmack@innerfire.net> writes:

>Actually at the place that just went bankrupt on me I had a Security
>consultant complain that 2 of my servers were outside the firewall.  He
>recommended that I get a firewall just for those 2 servers but backed off
>when I pointed out that I would need to open all of the same ports that
>are open on the server anyways so the vulnerability isn't any less with
>the firewall.

So you should've bought a more expensive firewall that offers protocol
based forwarding instead of being a simple packet filter.

packet filter != firewall. That's the main lie behind most of the
"Linux based" firewalls.

Get the real thing. Checkpoint. PIX. But that's a little
more expensive than "xxx firewall based on Linux".

Actually, there _are_ security consultants, that know what they're
talking about. Unfortunately they're drowned out most of the time by
the drone of so called "self-certified Linux experts" which believe,
everything can be handled by using the only tool they know.

>Never trust Security Consultants.

BS. Invest money in real consultants that know their trade. They
simply might not be the cheapest and they might tell you solutions
that hurt (e.g. training your staff) but of course there are lots of
people that know what they're talking about.

	Ciao
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
