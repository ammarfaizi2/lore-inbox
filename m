Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSHCVga>; Sat, 3 Aug 2002 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317849AbSHCVga>; Sat, 3 Aug 2002 17:36:30 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:32189 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317616AbSHCVga>;
	Sat, 3 Aug 2002 17:36:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] Rmap speedup
Date: Sat, 3 Aug 2002 23:41:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3D4B692B.46817AD0@zip.com.au> <Pine.LNX.4.44L.0208031803050.23404-100000@imladris.surriel.com> <3D4C4E7A.C6707A4C@zip.com.au>
In-Reply-To: <3D4C4E7A.C6707A4C@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b6eL-0002p1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 23:43, Andrew Morton wrote:
> > This could explain the fact that the locking overhead plummeted
> > on Daniel's box while it didn't change at all on your machine.
> 
> Oh it helped a bit.   More in 2.4 than 2.5.  Possibly I broke 
> Daniel's patch somehow.    But even the improvement in 2.4
> from Daniel's patch is disappointing.

What are the numbers for 2.4?  Are they for my out-of-the-box patch?

-- 
Daniel
