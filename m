Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUGOSvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUGOSvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 14:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUGOSvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 14:51:10 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:31180 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S266274AbUGOSvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 14:51:09 -0400
Date: Thu, 15 Jul 2004 11:51:08 -0700
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200407151851.i6FIp839003189@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [BK] x86_64 images available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've had several requests for a real 64bit BK release for AMD 64bit cpus.    
It's in the download area and in kernel.bkbits.net:/home/bk, the file is
called bk-3.2.2c-x86_64-glibc23-linux.bin.

It passes full regressions, both command line and GUI, but there were some
compiler warnings in the tcl/tk build so let us know if you see anything 
that appears not to work, especially in the GUI area.

--lm
