Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287112AbRL2Dvi>; Fri, 28 Dec 2001 22:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287113AbRL2Dv2>; Fri, 28 Dec 2001 22:51:28 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:3846 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287112AbRL2DvO>; Fri, 28 Dec 2001 22:51:14 -0500
Date: Fri, 28 Dec 2001 19:53:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Balanced Multi Queue Scheduler ...
Message-ID: <Pine.LNX.4.40.0112281949320.1023-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a bug fix and the use of the Time Slice Split Scheduler inside the
local CPUs schedulers. Versions from 0.46 to 0.52 are broken by the fixed
bug so testers should use this version :

http://www.xmailserver.org/linux-patches/mss-2.html#patches




- Davide


