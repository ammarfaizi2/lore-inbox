Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137154AbREKPUm>; Fri, 11 May 2001 11:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137156AbREKPUc>; Fri, 11 May 2001 11:20:32 -0400
Received: from tangens.hometree.net ([212.34.181.34]:43157 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S137154AbREKPUZ>; Fri, 11 May 2001 11:20:25 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: reiserfs, xfs, ext2, ext3
Date: Fri, 11 May 2001 15:20:23 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9dgvvn$n3h$1@forge.intermeta.de>
In-Reply-To: <20010511013913.D31966@emma1.emma.line.org> <172380000.989592181@tiny>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 989594423 24220 212.34.181.4 (11 May 2001 15:20:23 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 11 May 2001 15:20:23 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

>It requires explicit changes to each filesystem that wants to work over
>NFS, and is a somewhat large change.

Come on, we got zerocopy TCP pushed into a stable kernel release with
the words "get over it". 

So please, push this patch to Linus; I really like to "get over it". 

I think with the growing acceptance of ReiserFS in the Linux
community, it is tiresome to have to apply a patch again and again
just to get working NFS. 2.2 NFS horrors all over again.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
