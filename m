Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132739AbRDINLm>; Mon, 9 Apr 2001 09:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132736AbRDINLc>; Mon, 9 Apr 2001 09:11:32 -0400
Received: from tangens.hometree.net ([212.34.181.34]:6349 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S132742AbRDINLP>; Mon, 9 Apr 2001 09:11:15 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Proper way to release binary driver?
Date: Mon, 9 Apr 2001 13:11:12 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9ascdh$rh3$1@forge.intermeta.de>
In-Reply-To: <3ACDE5C5.CEB65D4A@raleigh.ibm.com> <E14lnvn-0007AS-00@the-village.bc.nu>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 986821872 24366 212.34.181.4 (9 Apr 2001 13:11:12 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 9 Apr 2001 13:11:12 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> We had hoped that MODVERSIONS would allow us to provide a single (or at
>> most a few) binary driver. Kernels with even minor version numbers are
>> supposed to be stable (even if they are buggy) ie. not have wildly
>> changing kernel interfaces.

>They have a stable API. THe ABI thing is an irrelevance to free software.
>avoiding the ABI compatibility mess is one of the great things free
>software lets you do.

^free^open source

	Ciao
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
