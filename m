Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281870AbRKSBaO>; Sun, 18 Nov 2001 20:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281871AbRKSBaE>; Sun, 18 Nov 2001 20:30:04 -0500
Received: from SAPba-01p112.ppp13.odn.ad.jp ([61.116.159.112]:9366 "HELO
	ender.dyndns.org") by vger.kernel.org with SMTP id <S281870AbRKSBaA>;
	Sun, 18 Nov 2001 20:30:00 -0500
Date: Mon, 19 Nov 2001 10:32:08 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
Message-ID: <20011119103208.A12346@alumni.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i-ja0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been running 2.4.14 since it came out and it works fine.  Try
running with/without the linux kernel agpgart.  That is, try it with the
nVidia agp driver and with the kernel agpgart to see if that may be
the problem.  If you need help you can ask people on IRC at
irc.openprojects.net, channel #nvidia.
