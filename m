Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316650AbSFKCBc>; Mon, 10 Jun 2002 22:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316652AbSFKCBb>; Mon, 10 Jun 2002 22:01:31 -0400
Received: from th00.opsion.fr ([195.219.20.10]:25862 "HELO th00.opsion.fr")
	by vger.kernel.org with SMTP id <S316650AbSFKCBb> convert rfc822-to-8bit;
	Mon, 10 Jun 2002 22:01:31 -0400
Send-By: 202.181.219.129 with Mozilla/4.78 [en] (Win95; U)
To: <linux-kernel@vger.kernel.org>
Subject: Re: mke2fs (and mkreiserfs) core dumps
From: <cnliou@eurosport.com>
X-Priority: 3 (normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 11 Jun 2002 02:01:10 GMT
Message-id: <200206110201.0ab3@th00.opsion.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am exeperiencing the similar problem in kernel
2.4.18, glibc 2.2.5, and patched gcc 2.95.3
(http://ricardo.ecn.wfu.edu/glib-linux-archive/0110/0
007.html).

Both of the following commands

mke2fs /dev/md0
mke2fs -j /dev/md0

output

File size limit exceeded

Please help and thank you in advance!

CN

--------------------------------------------------------
You too can have your own email address from Eurosport.
http://www.eurosport.com





