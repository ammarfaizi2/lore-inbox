Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSE1Mzx>; Tue, 28 May 2002 08:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSE1Mzw>; Tue, 28 May 2002 08:55:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55969 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314458AbSE1Mzv>;
	Tue, 28 May 2002 08:55:51 -0400
Date: Tue, 28 May 2002 05:40:43 -0700 (PDT)
Message-Id: <20020528.054043.06045639.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com, andrea@suse.de
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020528182806.A21303@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Tue, 28 May 2002 18:28:06 +0530
   
   Well, the last time RCU was discussed, Linus said that he would
   like to see someplace where RCU clearly helps.

Alexey and I are in firm agreement that the routing cache
clearly benefits from RCU.
