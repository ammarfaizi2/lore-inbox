Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbSAHDEe>; Mon, 7 Jan 2002 22:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287598AbSAHDEZ>; Mon, 7 Jan 2002 22:04:25 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:52681 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287595AbSAHDEU>; Mon, 7 Jan 2002 22:04:20 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 04:02:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020108030420Z287595-13997+1799@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to decide, now what should go into 2.4.18 (maybe -pre3) -aa or 
-rmap?
Andrew Morten`s read-latency.patch is a clear winner for me, too.
What about 00_nanosleep-5 and bootmem?
The O(1) scheduler?
Maybe preemption? It is disengageable so nobody should be harmed but we get 
the chance for wider testing.

Any comments?

Thanks,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
