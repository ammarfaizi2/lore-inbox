Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288228AbSACHNm>; Thu, 3 Jan 2002 02:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288229AbSACHNc>; Thu, 3 Jan 2002 02:13:32 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:7339 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288228AbSACHNU>; Thu, 3 Jan 2002 02:13:20 -0500
Date: Thu, 3 Jan 2002 09:10:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <andru@treshna.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Kernel Panics Problem
Message-ID: <Pine.LNX.4.33.0201030907360.28532-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the kernel panic "similar" each time or does it vary (visual inspection
should suffice) If it varies a lot, you may want to test your RAM for
defects (memtest86 is good). If its consistent, run the panic through
ksymoops, and send the decoded oops over to lkml.

HTH,
	Zwane Mwaikambo


