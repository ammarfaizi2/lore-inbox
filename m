Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSAZJHc>; Sat, 26 Jan 2002 04:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSAZJHL>; Sat, 26 Jan 2002 04:07:11 -0500
Received: from blinky.its.caltech.edu ([131.215.48.132]:48523 "EHLO
	blinky.its.caltech.edu") by vger.kernel.org with ESMTP
	id <S283003AbSAZJHJ>; Sat, 26 Jan 2002 04:07:09 -0500
Date: Sat, 26 Jan 2002 01:07:08 -0800 (PST)
From: Steven Hassani <hassani@its.caltech.edu>
X-X-Sender: hassani@blinky
To: linux-kernel@vger.kernel.org
Subject: Athlon Optimization Problem
Message-ID: <Pine.GSO.4.42.0201252339350.8662-100000@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm running a compaq presario 700us: duron 950 mhz on a via mobo
(vt8363/8365 etc).  When running kernel 2.4.17 with athlon optimizations,
the box has kernel panics, segmentation faults, and other errors.
When setting to K6 though, the box appears to be stable.  So does the fix
included in pci-pc.c not work with my system?  Has anyone else been
getting these errors after using this fix?  Thanks.
Steve

