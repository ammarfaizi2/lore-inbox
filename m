Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTAOF1A>; Wed, 15 Jan 2003 00:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTAOF07>; Wed, 15 Jan 2003 00:26:59 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:43785 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S265736AbTAOF06>; Wed, 15 Jan 2003 00:26:58 -0500
Message-Id: <3.0.6.32.20030115004522.007e5100@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 15 Jan 2003 00:45:22 -0500
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: [PATCH] page coloring for 2.4.20 kernel, version 2
In-Reply-To: <3.0.6.32.20030105150405.007dead0@boo.net>
References: <20030105193411.GJ9704@holomorphy.com>
 <200301051603.LAA18650@boo-mda02.boo.net>
 <200301051603.LAA18650@boo-mda02.boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Version 2 of the page coloring patch is ready. This version includes 
support for non-power-of-two cache sizes, fixes the ia64 cache detection 
code (thanks due to Alex Williamson), and fixes a small initialization bug.

New patch available at

www.boo.net/~jasonp/page_color-2.4.20-20030114.patch

Thanks in advance,
jasonp
