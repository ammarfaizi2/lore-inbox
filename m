Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281277AbRK0TcH>; Tue, 27 Nov 2001 14:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282749AbRK0Tb5>; Tue, 27 Nov 2001 14:31:57 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:48397 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281277AbRK0Tbl>; Tue, 27 Nov 2001 14:31:41 -0500
Date: Tue, 27 Nov 2001 11:41:56 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] LatSched ( scheduler latency sampler ) on 2.5.0 ...
Message-ID: <Pine.LNX.4.40.0111271138580.1576-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The cycle counter scheduler latency sampler has been ported to 2.5.0 with
a more robust userspace API :

http://www.xmailserver.org/linux-patches/lnxsched.html#LatSched



- Davide


