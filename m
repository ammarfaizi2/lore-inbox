Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272958AbRIHFXN>; Sat, 8 Sep 2001 01:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272959AbRIHFXD>; Sat, 8 Sep 2001 01:23:03 -0400
Received: from h24-76-60-12.vf.shawcable.net ([24.76.60.12]:42118 "HELO
	g-box.vf.shawcable.net") by vger.kernel.org with SMTP
	id <S272958AbRIHFWv>; Sat, 8 Sep 2001 01:22:51 -0400
Date: Fri, 7 Sep 2001 22:22:53 -0700 (PDT)
From: grue@lakesweb.com
Reply-To: grue@lakesweb.com
Subject: Feedback on preemptible kernel patch
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010908052256.A3DE9597C5@g-box.vf.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.4.10-pre4 with the rml-preempt patch.
built and rebooted this on my workstation yesterday when I saw the patch
posted and it's been working great.

I'm running it on a dual P3-550 with 256MB ram with CONFIG_SMP and no
problems whatsoever although it hasn't been worked 'real' hard yet.
(load no higher than 4) ;)

Figured I'd give some positive feedback about the patch. If you want,
Rob, I could run some benchmarks on this against an unpatched kernel, or
if you have some ideas for me to really stress this thing to see if it
breaks, let me know.

--
Gregory Finch


