Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265206AbSJWUyh>; Wed, 23 Oct 2002 16:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265213AbSJWUyh>; Wed, 23 Oct 2002 16:54:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40151 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265206AbSJWUyf>; Wed, 23 Oct 2002 16:54:35 -0400
Date: Wed, 23 Oct 2002 13:55:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: landley@trommello.org, linux-kernel@vger.kernel.org
cc: Guillaume Boissiere <boissiere@adiglobal.com>
Subject: Re: Crunch Time, in 3D!  (2.5 final merge candidate list, v 1.4)
Message-ID: <458250000.1035406518@flay>
In-Reply-To: <200210231040.33025.landley@trommello.org>
References: <200210221719.41868.landley@trommello.org> <2713947410.1035325439@[10.10.2.3]> <200210231040.33025.landley@trommello.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Try looking in -mm tree for anything that says hugetlb on it.
>> (or searching lkml for hugetlb subject lines). Yeah, I know
>> that's totally non-intuitive ;-)
>> This is large page support using more reasonable interfaces,
>> so it's actually useful.
> 
> Okay, now the important question:
> 
> Where can I find the patch?

http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm3/broken-out/

hugetlb-prefault.patch
hugetlb-header-split.patch
htlb-update.patch
hugetlb-page-count.patch
hugetlbfs.patch
hugetlb-shm.patch

I think that's all of it.

M.

