Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273846AbRI0UDF>; Thu, 27 Sep 2001 16:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRI0UCz>; Thu, 27 Sep 2001 16:02:55 -0400
Received: from pD9518E68.dip.t-dialin.net ([217.81.142.104]:9118 "EHLO
	df1tlpc.local.here") by vger.kernel.org with ESMTP
	id <S273846AbRI0UCp>; Thu, 27 Sep 2001 16:02:45 -0400
From: Klaus Dittrich <kladit@t-online.de>
Message-Id: <200109272002.WAA02203@df1tlb.local.here>
Subject: 2.4.10 and dd
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Sep 2001 22:02:07 +0200 (METDST)
Cc: klaus@df1tlb.local.here
Phone: 049-7151-987709
Fax: 049-7151-987709
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do my backup using dd if=/dev/sda of=/dev/sdb bs=1024k.

With 2.4.10 this does not work anymore.

An fsck of the filesystem (ext2) of /dev/sdb3 (~8GB) is impossible
because of too much errors.
 
System: SMP, 2 x PIII-800, BX-Chipset, 1 GB RAM, glibc-2.2.4

-- 
Best regards
Klaus Dittrich

e-mail: kladit@t-online.de
