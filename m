Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284653AbRLEUK2>; Wed, 5 Dec 2001 15:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284646AbRLEUKU>; Wed, 5 Dec 2001 15:10:20 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:15366 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284669AbRLEUJp>; Wed, 5 Dec 2001 15:09:45 -0500
Message-ID: <3C0E7ED9.1F0BD44E@zip.com.au>
Date: Wed, 05 Dec 2001 12:08:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Ravikiran G Thirumalai <kiran@in.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Scalable Statistics Counters
In-Reply-To: <20011205163153.E16315@in.ibm.com> <Pine.LNX.4.33L.0112051109340.4079-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> (it'd be so cool if we could just start using a statistic variable
> through some macro and it'd be automatically declared and visible
> in /proc ;))
> 

Marcelo and I worked out a thing which did that a while back.

http://www.zipworld.com.au/~akpm/linux/2.4/2.4.7/
