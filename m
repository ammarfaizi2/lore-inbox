Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275852AbRJKJfd>; Thu, 11 Oct 2001 05:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRJKJfW>; Thu, 11 Oct 2001 05:35:22 -0400
Received: from tangens.hometree.net ([212.34.181.34]:25787 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S275852AbRJKJfE>; Thu, 11 Oct 2001 05:35:04 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Tainted Modules Help Notices
Date: Thu, 11 Oct 2001 09:35:34 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9q3p56$tqo$1@forge.intermeta.de>
In-Reply-To: <20011011105016.C28145@devcon.net> <E15rc5o-0002cH-00@the-village.bc.nu>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1002792934 23816 212.34.181.4 (11 Oct 2001 09:35:34 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 11 Oct 2001 09:35:34 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> What about simply adding "BSD (included in kernel)" as a possible
>> "untainted" MODULE_LICENSE()?

>Sounds sane to me

How about 

"BSD (included in kernel source)" 

to make clear that this is part of the distributed kernel _sources_.

"included in kernel" could also be a 3rd party binary only driver
added by a Linux distribution vendor.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
