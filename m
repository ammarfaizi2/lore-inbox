Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRC3DHj>; Thu, 29 Mar 2001 22:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRC3DHU>; Thu, 29 Mar 2001 22:07:20 -0500
Received: from mtiwmhc24.worldnet.att.net ([204.127.131.49]:29608 "EHLO
	mtiwmhc24.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S130470AbRC3DHS>; Thu, 29 Mar 2001 22:07:18 -0500
Date: Thu, 29 Mar 2001 22:06:30 -0500
From: khromy <khromy@khromy.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: EXT2-fs error
Message-ID: <20010329220630.A32834@khromy.lnuxlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux vingeren.girl 2.4.3-pre7 #5 Mon Mar 26 23:33:59 EST 2001 i686 unknown

EXT2-fs error (device ide2(33,3)): ext2_free_blocks: bit already cleared for block 1048576
EXT2-fs error (device ide2(33,3)): ext2_free_blocks: bit already cleared for block 1048576

^
I got the following while rm -rf'ing my mozilla cvs checkout.  Deadly or not deadly?

-- 
L1:	khromy		;khromy(at)khromy.lnuxlab.net
