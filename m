Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271942AbRIIKFK>; Sun, 9 Sep 2001 06:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRIIKEu>; Sun, 9 Sep 2001 06:04:50 -0400
Received: from tangens.hometree.net ([212.34.181.34]:5582 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S271941AbRIIKEj>; Sun, 9 Sep 2001 06:04:39 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: nfs is stupid ("getfh failed")
Date: Sun, 9 Sep 2001 10:05:00 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9nfesc$ctr$1@forge.intermeta.de>
In-Reply-To: <m2ae06a6t7.fsf@euler.axel.nom> <E15fiJ6-0003sK-00@the-village.bc.nu>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1000029900 10155 212.34.181.4 (9 Sep 2001 10:05:00 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 9 Sep 2001 10:05:00 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> "Michael Rothwell" <rothwell@holly-springs.nc.us> writes:
>> 
>> > Just wondering if there's been any talk, plans, etc. of an alternative for
>> > NFS.
>> 
>> there's coda.

>You probably want inter-mezzo rather than coda for that kind of file
>service. Coda is a research project, inter-mezzo is kind of "distilled coda
>and afs", making it a real fs.  http://www.inter-mezzo.org

And it currently looks "Linux only", which kind of defeats IMHO the
purpose.

In a heterogenous environment there is NFS (and SMB aka CIFS aka <name
of the day>, of course. The horrors! The horrors! :-) ) and nothing
much else.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
