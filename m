Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbSJ3ALm>; Tue, 29 Oct 2002 19:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSJ3ALm>; Tue, 29 Oct 2002 19:11:42 -0500
Received: from ns.cinet.co.jp ([210.166.75.130]:48900 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S262411AbSJ3ALl>;
	Tue, 29 Oct 2002 19:11:41 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A314@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Jeff Garzik '" <jgarzik@pobox.com>
Cc: "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>,
       "'LKML '" <linux-kernel@vger.kernel.org>,
       "'Linus Torvalds '" <torvalds@transmeta.com>
Subject: RE: [PATCHSET 8/23] add support for PC-9800 architecture (fs)
Date: Wed, 30 Oct 2002 09:18:01 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

-----Original Message-----
From: Jeff Garzik
To: Osamu Tomita
Cc: Alan Cox; LKML; Linus Torvalds
Sent: 2002/10/30 2:54
Subject: Re: [PATCHSET 8/23] add support for PC-9800 architecture (fs)

> A general suggestion... some of your patches add headers to include/* 
> directories, when they are only included from one location in the tree. 
>  For that case, it is preferred to place the header in the same 
> directory as the code which includes the header.
I see. I'll serach file that you said, and move it.

Regards,
Osamu Tomita

