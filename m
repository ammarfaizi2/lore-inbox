Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSJDEu5>; Fri, 4 Oct 2002 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSJDEu5>; Fri, 4 Oct 2002 00:50:57 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:16652 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S261489AbSJDEud>; Fri, 4 Oct 2002 00:50:33 -0400
Subject: FAT/VFAT and the sync flag
From: Scott Bronson <bronson@rinspin.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Oct 2002 21:51:25 -0700
Message-Id: <1033707085.6359.113.camel@emma>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone tell me if the VFAT filesystem actually recognizes the sync
flag?  Early in 2.4, it appeared that it was ignoring it.

However, now that a lot of USB devices are VFAT, this gets pretty
important.

Thanks,

    - Scott


