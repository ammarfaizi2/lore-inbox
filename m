Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316450AbSEUAGm>; Mon, 20 May 2002 20:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316453AbSEUAGl>; Mon, 20 May 2002 20:06:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63475 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316450AbSEUAGj>; Mon, 20 May 2002 20:06:39 -0400
Subject: [PATCH] updated O(1) scheduler for 2.4
From: Robert Love <rml@mvista.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 May 2002 17:06:39 -0700
Message-Id: <1021939600.967.5.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated versions of the O(1) scheduler for 2.4 are available at:

http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.18-4.patch
http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.19-pre8-1.patch

for 2.4.18 and 2.4.19-pre8.  Please use a mirror.

These patches include all included and pending bits from 2.4-ac and 2.5
as well as my user-configurable maximum RT priority patch.  This is more
up-to-date than any other tree, in fact. ;-)

In general, I recommend using 2.4-ac or waiting for 2.6 if you want the
O(1) scheduler - this is not suggested for inclusion in 2.4 - but for
those who care, here it is.

Enjoy,

	Robert Love

