Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSIODiy>; Sat, 14 Sep 2002 23:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSIODiy>; Sat, 14 Sep 2002 23:38:54 -0400
Received: from dsl-213-023-043-058.arcor-ip.net ([213.23.43.58]:4256 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317694AbSIODix>;
	Sat, 14 Sep 2002 23:38:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.34-mm2
Date: Sun, 15 Sep 2002 05:46:38 +0200
X-Mailer: KMail [version 1.3.2]
References: <3D803434.F2A58357@digeo.com>
In-Reply-To: <3D803434.F2A58357@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qQMq-0001JV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 08:29, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm2/
>
> -sleeping-release_page.patch

What's this one?  Couldn't find it as a broken-out patch.

On the nonblocking vm front, does it rule or suck?  I heard you
mention, on the one hand, huge speedups on some load (dbench I think)
but your in-patch comments mention slowdown by 1.7X on kernel
compile.

-- 
Daniel
