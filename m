Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbRDNVFU>; Sat, 14 Apr 2001 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRDNVFL>; Sat, 14 Apr 2001 17:05:11 -0400
Received: from cr65188-a.crdva1.bc.wave.home.com ([24.153.54.85]:47631 "HELO
	brewt.org") by vger.kernel.org with SMTP id <S132547AbRDNVE5>;
	Sat, 14 Apr 2001 17:04:57 -0400
Date: Sat, 14 Apr 2001 14:04:51 -0700 (PDT)
From: xcp <xcp@brewt.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: "uname -p" prints unknown for Athlon K7 optimized kernel?
Message-ID: <Pine.LNX.4.30.0104141358390.16100-100000@stinky.brewt.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uname has printed unknown for the cpu vendor for as long as I can
remember.
There is a hacked uname.c distributed as "nuname" that works for cyrix
intel and amd, maybe others.

http://cds.duke.edu/pub/sunsite/utils/shell/nuname-1.0.tar.gz

I *think* Cyrix shows up as CyrixInstead

Dual P120
Linux mandelbrot 2.4.4-pre3 #2 SMP Sat Apr 14 12:15:33 PDT 2001 i586
GenuineIntel

Athlon 1Ghz
Linux noc 2.4.3 #1 Fri Mar 30 12:44:13 PST 2001 i686 AuthenticAMD

Dual P3-450
Linux sandbox 2.4.3 #1 SMP Sat Mar 31 17:40:57 PST 2001 i686 GenuineIntel

