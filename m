Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbSJaQao>; Thu, 31 Oct 2002 11:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSJaQao>; Thu, 31 Oct 2002 11:30:44 -0500
Received: from mail.hometree.net ([212.34.181.120]:59032 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S263211AbSJaQal>; Thu, 31 Oct 2002 11:30:41 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: What's left over.
Date: Thu, 31 Oct 2002 16:37:07 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aprm7j$62r$1@forge.intermeta.de>
References: <20021031020836.E576E2C09F@lists.samba.org> <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036082227 24441 212.34.181.4 (31 Oct 2002 16:37:07 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 31 Oct 2002 16:37:07 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

>> ext2/ext3 ACLs and Extended Attributes

>I don't know why people still want ACL's. There were noises about them for 
>samba, but I'v enot heard anything since. Are vendors using this?

CIFS/SMB. Replacing Windows Fileservers. Supporting the required Windows
semantics. World domination.

That's one patch I personally consider really important. Getting the API in
place and a couple of FSses supporting it. The rest is up to user space.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
