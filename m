Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132243AbRCYWyJ>; Sun, 25 Mar 2001 17:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132244AbRCYWx7>; Sun, 25 Mar 2001 17:53:59 -0500
Received: from mtiwmhc24.worldnet.att.net ([204.127.131.49]:19930 "EHLO
	mtiwmhc24.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S132243AbRCYWxk>; Sun, 25 Mar 2001 17:53:40 -0500
Date: Sun, 25 Mar 2001 17:54:03 -0500
From: goldencat@ezdelivery.dnsalias.net
Message-Id: <200103252254.RAA01850@ezdelivery.dnsalias.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 NINI_PARTITION
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

msdos.c MINI_PARTITION underclared (first use in this function)
msdos.c MINI_NR_SUBPARTITIONS' undeclared (first use in this function)
check msdos.c msdos.h
can not find MINI_PARTITION/MINI_NR_SUBPARTITIONS
is this a bug?
