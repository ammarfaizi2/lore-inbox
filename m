Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270849AbRHSWmm>; Sun, 19 Aug 2001 18:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270848AbRHSWme>; Sun, 19 Aug 2001 18:42:34 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:21966 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S270825AbRHSWmY>; Sun, 19 Aug 2001 18:42:24 -0400
Date: Sun, 19 Aug 2001 15:42:08 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: David Ford <david@blue-labs.org>, otto.wyss@bluewin.ch,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why don't have bits the same rights as humans! (flushing to disk
 waiting  time)
In-Reply-To: <20010820003612.A29624@unthought.net>
Message-ID: <Pine.GSO.4.10.10108191541280.9758-100000@eclipse-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> If you absolutely must write to a FAT filesystem on the floppy, you can
> use the mtools package (mcopy, mdir, mformat, ...) - again, you won't have to
> mount or unmount, writes are not buffered, etc. etc.

Or just type sync. :-)


