Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265893AbSKBIYA>; Sat, 2 Nov 2002 03:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSKBIYA>; Sat, 2 Nov 2002 03:24:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265893AbSKBIX7>;
	Sat, 2 Nov 2002 03:23:59 -0500
Message-ID: <3DC38CF4.1060301@pobox.com>
Date: Sat, 02 Nov 2002 03:29:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Huge TLB pages always physically continious?
References: <20021101235620.A5263@nightmaster.csn.tu-chemnitz.de> <3DC30CD6.D92D0F9F@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that hugetlbfs is merged, can we remove the hugetlb syscalls? 
 Pretty please?  ;-)

What I've heard in the background is that all the Big Users(tm) of 
hugetlbs greatly prefer the existing syscalls (a.k.a. hugetlbfs) to 
adding support to new ones in the various userland portability layers in 
use...

    Jeff




