Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbTA1D0v>; Mon, 27 Jan 2003 22:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTA1D0v>; Mon, 27 Jan 2003 22:26:51 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:270 "EHLO boo-mda02.boo.net")
	by vger.kernel.org with ESMTP id <S262824AbTA1D0v>;
	Mon, 27 Jan 2003 22:26:51 -0500
Message-Id: <3.0.6.32.20030127224726.00806c20@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 27 Jan 2003 22:47:26 -0500
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: [PATCH] page coloring for 2.5.59 kernel, version 1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is yet another holding action, a port of my page coloring patch
to the 2.5 kernel. This is a minimal port (x86 only) intended to get
some testing done; once again the algorithm used is the same as in 
previous patches. There are several cleanups and removed 2.4-isms that
make the code somewhat more compact, though.

I'll be experimenting with other coloring schemes later this week.

www.boo.net/~jasonp/page_color-2.5.59-20030127.patch

Feedback of any sort welcome.

jasonp
