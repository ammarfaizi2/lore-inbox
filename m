Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSK1JGp>; Thu, 28 Nov 2002 04:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSK1JGo>; Thu, 28 Nov 2002 04:06:44 -0500
Received: from mail.hometree.net ([212.34.181.120]:63140 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265326AbSK1JGX>; Thu, 28 Nov 2002 04:06:23 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: reiserfs bug
Date: Thu, 28 Nov 2002 09:13:43 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <as4mo7$ae8$1@forge.intermeta.de>
References: <072801c296b8$2cb01000$6600a8c0@topconcepts.net> <20021128114755.A2724@namesys.com> <077201c296bb$43b4ac40$6600a8c0@topconcepts.net> <20021128115708.A2792@namesys.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1038474823 23606 212.34.181.4 (28 Nov 2002 09:13:43 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 28 Nov 2002 09:13:43 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> writes:

>Sorry, but you seems to have faulty hardware (bad harddrive or something).
>Reiserfs cannot tolerate bad blocks in journal area right now.
>I'd suggest you to make a backup of your device and then to replace bad
>harddrive.

You still shouldn't panic the kernel in this case. IMHO.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
