Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280633AbRKJNU6>; Sat, 10 Nov 2001 08:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280634AbRKJNUj>; Sat, 10 Nov 2001 08:20:39 -0500
Received: from [196.31.58.45] ([196.31.58.45]:8584 "EHLO
	montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S280633AbRKJNUa>; Sat, 10 Nov 2001 08:20:30 -0500
Message-Id: <200111101322.fAADMht02396@montezuma.mastecende.com>
Content-Type: text/plain; charset=US-ASCII
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockup in IDE code
Date: Sat, 10 Nov 2001 15:22:42 +0200
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Zealey - 2001-11-09 12:40:41 PST
>Well, obviously your drive or mobo doesn't support DMA. I noticed that all 
>the other devices (hd[acd]) were in PIO mode, why not try setting dma mode 
>on one of them. Most CD's I've come across don't do DMA very well, I believe 
>that the DMA is mostly only useful for DVD's, where you need a high transfer 
>rate to watch a movie.

He probably doesn't have anything on the primary master and seconday 
master/slaves. And UDMA has worked very well for most CDROM drives i've come 
across, but then as always YMMV.

Cheers,
	Zwane
