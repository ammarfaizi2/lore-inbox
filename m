Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSKFRGQ>; Wed, 6 Nov 2002 12:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265838AbSKFRGQ>; Wed, 6 Nov 2002 12:06:16 -0500
Received: from stingr.net ([212.193.32.15]:63497 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S265843AbSKFRGP>;
	Wed, 6 Nov 2002 12:06:15 -0500
Date: Wed, 6 Nov 2002 20:12:50 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.5.46-mm1
Message-ID: <20021106171249.GB29935@stingr.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
References: <3DC8D423.DAD2BF1A@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DC8D423.DAD2BF1A@digeo.com>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Andrew Morton:
> stabilisation and for people to sync up against.  And also to keep things
> like shared pagetables and dcache-rcu under test.

Why sharepte is dependent on highmem now ?

I thought I will benefit from it on forkloads on lowmem too ...

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
