Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271810AbRIEOFg>; Wed, 5 Sep 2001 10:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271822AbRIEOF1>; Wed, 5 Sep 2001 10:05:27 -0400
Received: from tangens.hometree.net ([212.34.181.34]:45756 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S271810AbRIEOFO>; Wed, 5 Sep 2001 10:05:14 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Linux 2.4.9-ac6
Date: Wed, 5 Sep 2001 14:05:32 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9n5bfc$i7c$1@forge.intermeta.de>
In-Reply-To: <1257554973.999687013@[169.254.198.40]> <NOEJJDACGOHCKNCOGFOMAECKDLAA.davids@webmaster.com> <20010905145039.A10655@pc8.lineo.fr>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 999698732 18821 212.34.181.4 (5 Sep 2001 14:05:32 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 5 Sep 2001 14:05:32 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr> writes:

>Would it not be possible with your scheme to package a closed source driver
>in an open source wrapper driver and then defeat your tainting technique.

>Is it legally possible to copyright a kind of magic number with a copyright
>allowing only it's used in open & public source driver ?

Congratulations, you've just invented the Microsoft HW Labs
certification procedure with module signing. ;-)

I can really see it:

# insmod <module>
This module <module> is not signed with the Linus Torvalds Hardware
Certification Labs key.

Do you want to

a) insert the module anyway (Errors and Crashes from your kernel will
not be processed by major kernel developers
b) not insert the module
c) search for an alternative driver that is open source, download it,
   compile it and use that instead of <module>
d) download a skeleton driver to write your own driver
e) install Microsoft Windows XP
f) exit

-> f
# 

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
