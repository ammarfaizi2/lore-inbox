Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRKVOvA>; Thu, 22 Nov 2001 09:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279783AbRKVOuu>; Thu, 22 Nov 2001 09:50:50 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:14224 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279768AbRKVOun>; Thu, 22 Nov 2001 09:50:43 -0500
Date: Thu, 22 Nov 2001 16:57:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
Message-ID: <Pine.LNX.4.33.0111221653290.28285-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm i've always been under the impression that those strings are hard
encoded into the CPU so even if we're on a motherboard/bios which doesn't
"support" that particular CPU we can do a cpuid and get the same string.

Regards,
	Zwane Mwaikambo


