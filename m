Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSEMLoN>; Mon, 13 May 2002 07:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSEMLoM>; Mon, 13 May 2002 07:44:12 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:33471 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S312973AbSEMLoL>; Mon, 13 May 2002 07:44:11 -0400
Date: Mon, 13 May 2002 07:45:14 -0400
To: jamagallon@able.es
Cc: linux-kernel@vger.kernel.org
Subject: [PATCHSET] Linux 2.4.19-pre8-jam2
Message-ID: <20020513074514.A25499@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Re-introduction of wake_up_sync to make pipes run fast again. No idea
>  about this is useful or not, that is the point, to test it (Randy ?)

Thanks, I was hoping someone would port that patch to a 2.4 kernel.
2.5 kernels <= 2.5.15 aren't completing umount on the 4 way Xeon.
I will benchmark the latest jam on the big box next.

http://home.earthlink.net/~rwhron/kernel/bigbox.html

-- 
Randy Hron

