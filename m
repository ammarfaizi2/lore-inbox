Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSE3M3y>; Thu, 30 May 2002 08:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSE3M3x>; Thu, 30 May 2002 08:29:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56548 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316599AbSE3M3x>; Thu, 30 May 2002 08:29:53 -0400
Date: Thu, 30 May 2002 14:29:13 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "David S. Miller" <davem@redhat.com>
cc: <mathieu@newview.com>, <andre@linux-ide.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre9, IDE on Sparc, Big Disks
Message-ID: <Pine.SOL.4.30.0205301424440.2028-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I fixed this endianness mess some time ago, patch is included in 2.5.x
but for some reason not in 2.4.x, although Andre was informed about
problem and send patch ...

--
bkz

