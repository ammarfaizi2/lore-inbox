Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281580AbRKMJ6w>; Tue, 13 Nov 2001 04:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281576AbRKMJ6o>; Tue, 13 Nov 2001 04:58:44 -0500
Received: from tangens.hometree.net ([212.34.181.34]:31922 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S281577AbRKMJ5i>; Tue, 13 Nov 2001 04:57:38 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: [OT] Coding Style (was: Re: GPLONLY kernel symbols???)
Date: Tue, 13 Nov 2001 09:57:37 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9sqqqh$4a6$1@forge.intermeta.de>
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca> <3BF09E44.58D138A6@mandrakesoft.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1005645457 27550 212.34.181.4 (13 Nov 2001 09:57:37 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 13 Nov 2001 09:57:37 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

>He and davej still have a point.  Your code formatting is non-standard,
>and is difficult to read.  A document exists CodingStyle which explains
>a good style, and further -why- it is a good style.

Oh yes, words like

--- cut ---
but all right-thinking people know that (a) K&R are _right_ and (b)
K&R are right.  Besides, functions are special anyway (you can't nest
them in C).
--- cut ---

Is really a satisfing descrption _why_ it is a good style. :-)

(I actually agree with 99% of the coding style but my braces will
always be GNU. ;-) And K&R braces suck in Java. (ducks and runs)).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
