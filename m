Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSLIONg>; Mon, 9 Dec 2002 09:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSLIONg>; Mon, 9 Dec 2002 09:13:36 -0500
Received: from mail.hometree.net ([212.34.181.120]:8922 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265516AbSLIONf>; Mon, 9 Dec 2002 09:13:35 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: IDE feature request
Date: Mon, 9 Dec 2002 14:21:17 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <at28st$ifd$1@forge.intermeta.de>
References: <068d01c29d97$f8b92160$551b71c3@krlis> <1039312135.27904.11.camel@irongate.swansea.linux.org.uk> <20021208234102.GA8293@scssoft.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1039443677 3111 212.34.181.4 (9 Dec 2002 14:21:17 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 9 Dec 2002 14:21:17 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Sebor <petr@scssoft.com> writes:


>--azLHFNyN32YCQGCU
>Content-Type: text/plain; charset=us-ascii
>Content-Disposition: inline

>On Sun, Dec 08, 2002 at 01:09:34AM +0000, Alan Cox wrote:
>> Fix ide.c to generate a b c d e f and you should be able to get 16.

>Like this?

Hmm,

you will get the same problem again, once someone is able to cram more than
16 IDE hosts into a box. Why not go for ide%d (ide0-9, ide10-99)?

If we go to idea - idef now, we will be stuck with that for ages.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
