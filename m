Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265697AbSKFRSO>; Wed, 6 Nov 2002 12:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSKFRSO>; Wed, 6 Nov 2002 12:18:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:4287 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265697AbSKFRSN>;
	Wed, 6 Nov 2002 12:18:13 -0500
Message-ID: <3DC9505C.7D16DD73@digeo.com>
Date: Wed, 06 Nov 2002 09:24:44 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul P Komkoff Jr <i@stingr.net>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.5.46-mm1
References: <3DC8D423.DAD2BF1A@digeo.com> <20021106171249.GB29935@stingr.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 17:24:44.0939 (UTC) FILETIME=[662BDDB0:01C285B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr wrote:
> 
> Replying to Andrew Morton:
> > stabilisation and for people to sync up against.  And also to keep things
> > like shared pagetables and dcache-rcu under test.
> 
> Why sharepte is dependent on highmem now ?
> 

Senility?   Just delete line 725 of arch/i386/Kconfig
