Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277434AbRJJV5E>; Wed, 10 Oct 2001 17:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277435AbRJJV4y>; Wed, 10 Oct 2001 17:56:54 -0400
Received: from [213.97.45.174] ([213.97.45.174]:52743 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S277434AbRJJV4h>;
	Wed, 10 Oct 2001 17:56:37 -0400
Date: Wed, 10 Oct 2001 23:56:59 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.10-ac10 memory management better than sliced bread
Message-ID: <Pine.LNX.4.33.0110102345390.1538-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been running it for more than 48 hours and it has performed very
well, improving the former releases.

The memory management acts very well, not throwing away too many pages,
making normal uses like switching among desktops a fast operation.
I can open tenths of terms, run mysql, galeon with many windows, compile
the kernel, update many rpms.... all at the same time and the system still
feels responsive.

Applications that are linked to many libraries (read gnome apps) also
perform much better upon start.

Well, I just wanted to point out that it looks like we are reaching a
stable and predictible behaviour. It's a pitty that this branch is so
different from Linus' as merging does not seem possible, just swapping
from one to the other. Is there any fair comparison between both
approaches?

Pau

