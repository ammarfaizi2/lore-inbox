Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268737AbUILOaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbUILOaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 10:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268742AbUILOaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 10:30:24 -0400
Received: from nefty.hu ([195.70.37.175]:64668 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S268737AbUILOaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 10:30:21 -0400
Date: Sun, 12 Sep 2004 16:30:19 +0200 (CEST)
From: Zoltan NAGY <nagyz@nefty.hu>
To: linux-kernel@vger.kernel.org
Cc: koszik@atw.hu
Subject: e1000 problem
Message-ID: <Pine.LNX.4.58.0409121624360.14535@nefty.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

we've recetly tried to migrate from 2.4.26-grsec to 2.6.8.1, but it
has failed miserably.

when using 2.4.26, we can achieve 500-600mbit/sec throughput through our
e1000, but when using 2.6.8.1 it has dropped down to around 100mbit/sec
(with 100% cpu usage, no idle time [while at least with 2.4 we had some],
cpu usage grows while we dont shut the box down..)

it's a supermicro x5dp8 board, with e7505, adaptec 7902, using aacraid
scsiraid as the disk subsystem.

any thoughts?

please cc me, as I'm not subscribed.

regards,

--
Zoltan NAGY,
Software Engineer

