Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSK0O50>; Wed, 27 Nov 2002 09:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSK0O50>; Wed, 27 Nov 2002 09:57:26 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9370 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262871AbSK0O5Y>; Wed, 27 Nov 2002 09:57:24 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46: Filesystem capabilities
Date: Wed, 27 Nov 2002 16:04:28 +0100
Message-ID: <87d6or2gw3.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Martin,

das d=FCrfte dich interessieren.

Gru=DF, Olaf.


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

X-From-Line: linux-kernel-owner+olaf.dietsche=23list.linux-kernel=40t-online.de@vger.kernel.org  Wed
 Nov 27 15:11:06 2002

>From smmta  Wed Nov 27 15:11:06 2002
Return-Path: <linux-kernel-owner+olaf.dietsche=23list.linux-kernel=40t-online.de@vger.kernel.org>
Received: from localhost (localhost [127.0.0.1])
	by goat.bogus.local (8.12.6/8.12.6) with ESMTP id gAREB6NT013308
	for <olaf@localhost>; Wed, 27 Nov 2002 15:11:06 +0100
Received: from fwdallmx.t-online.com [194.25.134.26]
	by localhost with POP3 (fetchmail-6.1.0)
	for olaf@localhost (single-drop); Wed, 27 Nov 2002 15:11:06 +0100 (MET)
Received: from vger.kernel.org ([209.116.70.75]) by mailin06.sul.t-online.de
	with esmtp id 18H2TT-0WqWCua; Wed, 27 Nov 2002 14:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSK0Nbf>; Wed, 27 Nov 2002 08:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSK0Nbf>; Wed, 27 Nov 2002 08:31:35 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:49040 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262580AbSK0Nbe>; Wed, 27 Nov 2002 08:31:34 -0500
Received: from fwd11.sul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 18H2Ox-0006eJ-0K; Wed, 27 Nov 2002 14:38:51 +0100
Received: from margit.t-online.de (520024700093-0001@[217.224.17.147]) by
 fwd11.sul.t-online.com
	with esmtp id 18H2Ot-24zrTEC; Wed, 27 Nov 2002 14:38:47 +0100
Message-Id: <4.3.2.7.2.20021127143633.00b5fae0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: 	Wed, 27 Nov 2002 14:39:14 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
X-Sender: 520024700093-0001@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: 	linux-kernel@vger.kernel.org
Lines: 11
Xref: goat.bogus.local list.linux-kernel:266223
MIME-Version: 1.0

 >Fortunately, 1.28 didn't get adopted by any distro's as far as I know,
It got into Suse 8.1

Margit 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


--=-=-=


This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- 

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.

--=-=-=--
