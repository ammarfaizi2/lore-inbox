Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313156AbSDDJIm>; Thu, 4 Apr 2002 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313144AbSDDJIc>; Thu, 4 Apr 2002 04:08:32 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:39121 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S313149AbSDDJIQ>;
	Thu, 4 Apr 2002 04:08:16 -0500
Date: Thu, 4 Apr 2002 18:08:11 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5
Message-ID: <Pine.LNX.4.44.0204041802310.549-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AlphaPC 264DP 666 MHz (Tsunami, UP)
1GB RAM
gcc version 3.0.3

Running stuff as usual, reading large files, I can often get
very long mouse freezes when redrawing a certain window in X after
leaving it for a while.  I never saw this behavior in 2.4.18-rc1,
which I ran for over 1 month doing the same stuff.  vmstat doesn't
report swapping activity that I can see, just a window that should
refresh (no backing store) right away causes long (2~5 sec) freezes.


