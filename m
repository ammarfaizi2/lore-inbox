Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318944AbSHFA3G>; Mon, 5 Aug 2002 20:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318948AbSHFA3F>; Mon, 5 Aug 2002 20:29:05 -0400
Received: from maddog.sal.wisc.edu ([144.92.179.20]:19251 "EHLO
	maddog.sal.wisc.edu") by vger.kernel.org with ESMTP
	id <S318944AbSHFA3F>; Mon, 5 Aug 2002 20:29:05 -0400
From: Richard Bonomo <bonomo@sal.wisc.edu>
Message-Id: <200208060032.g760WZP107993@maddog.sal.wisc.edu>
Subject: backups/dumps/caches
To: linux-kernel@vger.kernel.org
Date: Mon, 5 Aug 2002 19:32:34 -0500 (CDT)
Cc: bonomo@maddog.sal.wisc.edu (Richard Bonomo)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I have been trying to come up to speed on
the issue of dumping file systems from
2.4.x kernels using dumps.  I located 
Linus' unequivocal words about the dangers
of using dump.   I have a couple of questions:

1. Do the same warnings apply to XFS and xfsdump?
   (Is the caching system used with the newer
    kernel used only with certain file system types?)

2. Perhaps, naively, is it possible to shut off
  caching temporarily (and without rebooting),
  accepting the performance hit, while a dump
  is done, and then restart caching afterwards?

Please cc a reply directly to me (bonomo@sal.wisc.edu),
as I am not a regular member of this list (at least,
not yet...)

Thank you!

Richard B.

-- 
************************************************
Richard Bonomo
UW Space Astronomy Laboratory
ph: (608) 263-4683 telefacsimile: (608) 263-0361
SAL-related email: bonomo@sal.wisc.edu
all other email: bonomo@ece.wisc.edu
web page URL: http://www.cae.wisc.edu/~bonomo
************************************************
