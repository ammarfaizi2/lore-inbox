Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271826AbRICVBZ>; Mon, 3 Sep 2001 17:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271822AbRICVBG>; Mon, 3 Sep 2001 17:01:06 -0400
Received: from 200-206-139-161.dsl.telesp.net.br ([200.206.139.161]:43781 "EHLO
	blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S271819AbRICVA6>; Mon, 3 Sep 2001 17:00:58 -0400
Date: Mon, 3 Sep 2001 18:01:11 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: <linux-kernel@vger.kernel.org>
Subject: ps -ax hang with Mozilla in 2.4.9
Message-ID: <Pine.LNX.4.32.0109031759040.9457-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

Just wondering if anybody has had moz hanging on them and hanging 'ps -ax'
(which means /proc/kmem reading is hung, IIRC)? This _never_ happened
before 2.4.9, and I do mozilla QA so I'd have seen it; i've seen all sorts
of crash with it :)

How can I debug this properly?

What were the changes that were reported in 2.4.9 that made mozilla
"better", exactly? I only see this happening with mozilla, but there may
be others. Let me know.

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 272 3330 | NMFL

