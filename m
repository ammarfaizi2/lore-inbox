Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316262AbSEQP05>; Fri, 17 May 2002 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316263AbSEQP04>; Fri, 17 May 2002 11:26:56 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2]:13249 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id <S316262AbSEQP04>; Fri, 17 May 2002 11:26:56 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <15588.18673.317088.198281@wombat.chubb.wattle.id.au>
	<E178VRs-0008Va-00@starship>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: 17 May 2002 10:26:48 -0500
Message-ID: <ufait5mlrrb.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "DP" == Daniel Phillips <phillips@bonn-fries.net> writes:

DP> Incidently, the 200 TB high-end servers are a lot closer than you
DP> think.

Perhaps the "low-end server" is a more interesting case, though.
After all, you can put over 4TB in one machine now for somewhere near
$12K.  (32 160GB IDE disks on four 3ware 7850 cards running RAID5, all
striped into one huge "RAID50" array.)  This is only going to get
cheaper, and when someone out-does Maxtor for the "big IDE disk" crown,
the capacity will jump again.  Of course it doesn't have the same
performance or extreme reliability of the more expensive solutions,
but hey, it only costs $12K.

Still, 16TB done this way looks to be a few years away yet.

 - J<
