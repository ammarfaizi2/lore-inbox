Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTAYDvt>; Fri, 24 Jan 2003 22:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbTAYDvt>; Fri, 24 Jan 2003 22:51:49 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:3739 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266114AbTAYDvs>; Fri, 24 Jan 2003 22:51:48 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 24 Jan 2003 20:06:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Janet Morgan <janetmor@us.ibm.com>
Subject: [patch] epoll for 2.4.20 updated ...
Message-ID: <Pine.LNX.4.50.0301242004010.2858-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I updated the 2.4.20 patch with the changes posted today and I fixed a
little error about the wait queue function prototype :

http://www.xmailserver.org/linux-patches/sys_epoll-2.4.20-0.61.diff



- Davide

