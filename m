Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTFROEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTFROEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:04:25 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:1545 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S265105AbTFROEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:04:23 -0400
Date: Wed, 18 Jun 2003 16:18:17 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>, <debian-glibc@lists.debian.org>
Subject: VIA Ezra CentaurHauls
Message-ID: <Pine.LNX.4.33.0306181205180.2967-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We have a platform with the above processor, and we happened to have 2
revisions thereof: stepping 8 and 10. With stepping 8 we are getting
"random" application crashes (segfaults), sometimes with kernel-Oopses.
The distribution is Debian-Woody. I saw some messages on the Debian
mailing list about problems with exactly this CPU, however, it was not
related to different revisions (stepping), perhaps, the author only had
 / tried stepping 8. The fix was to upgrade libc. I've done this (to
version libc6_2.3.1-16, but it didn't help. Any ideas?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany


