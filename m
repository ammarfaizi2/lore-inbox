Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135240AbRDRR6N>; Wed, 18 Apr 2001 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135241AbRDRR6D>; Wed, 18 Apr 2001 13:58:03 -0400
Received: from galeb.etf.bg.ac.yu ([147.91.8.64]:39954 "EHLO
	galeb.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S135240AbRDRR54>; Wed, 18 Apr 2001 13:57:56 -0400
Date: Wed, 18 Apr 2001 19:56:25 +0200 (CEST)
From: Dragan Milenkovic <tyrant@galeb.etf.bg.ac.yu>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: uname ?
Message-ID: <Pine.LNX.4.21.0104181938060.14886-100000@galeb.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<rpm-related>
Few days ago, I found an incredibly usable option in latest gcc versions.
gcc -march=k6 -mcpu=k6
I started rebuilding SRPMS with these as optflags, just to find out that
some packages don't use optflags, but use -march=`uname -m`.
So ...
</rpm-related>

What about uname -m and non-Intel processors? Is there going to be
a change? I hope we all agree that K6 is not i586 or i686.
I vote for breaking compatibility!

-- 
Dragan

