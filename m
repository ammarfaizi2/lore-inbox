Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279406AbRJWMcL>; Tue, 23 Oct 2001 08:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279407AbRJWMcB>; Tue, 23 Oct 2001 08:32:01 -0400
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:9387 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S279406AbRJWMbt>; Tue, 23 Oct 2001 08:31:49 -0400
Date: Tue, 23 Oct 2001 08:32:14 -0400
To: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.10-- Unable to handle kernel paging request
Message-ID: <20011023083214.A28405@rochester.rr.com>
In-Reply-To: <20011017110045.A5444@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011017110045.A5444@rochester.rr.com>
User-Agent: Mutt/1.3.20i
From: jstrand1@rochester.rr.com (James D Strandboge)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I thought I would send a reply to my own Oops, so when this
hits the archives, maybe someone can get something from it.  As it
turns out, it was bad RAM that was causing the problem.  With 2.2 I
never got Sig 11s on kernel compiles, but I tried a 2.4 compile on
this machine and sure enough, Sig 11.  Other tests revealed it was
NOT a kernel bug, but instead RAM.

Sorry for the posts.

Jamie
-- 
GPG/PGP Info
Email:        jstrand1@rochester.rr.com
ID:           26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A
--
