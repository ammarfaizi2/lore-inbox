Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTCEXcJ>; Wed, 5 Mar 2003 18:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTCEXcJ>; Wed, 5 Mar 2003 18:32:09 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18990 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266987AbTCEXcI>; Wed, 5 Mar 2003 18:32:08 -0500
Date: Wed, 5 Mar 2003 18:42:38 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200303052342.h25Ngcs26177@devserv.devel.redhat.com>
To: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: system lockup issues w/ 2.4.19
In-Reply-To: <mailman.1046898841.30893.linux-kernel2news@redhat.com>
References: <mailman.1046898841.30893.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> About once a month or so (not very regular), one or the other of our Dell 
> PowerEdge servers goes catatonic.  Examining the system in this state, it 
> seems to exhibit the symptoms of a full process table, in that no new 
> processes can be started at all.

It is essential that you explained how you did the examining,
with relevant shell traces/snapshots, etc. If they are too
long, upload them somewhere. And use of stock kernels goes
without saying, or you have to go to your vendor (SuSE).

-- Pete
