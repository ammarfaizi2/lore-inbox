Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTLSNyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 08:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTLSNyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 08:54:50 -0500
Received: from [66.98.192.92] ([66.98.192.92]:36064 "EHLO svr44.ehostpros.com")
	by vger.kernel.org with ESMTP id S262960AbTLSNys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 08:54:48 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: linux-kernel@vger.kernel.org
Subject: powerpc kgdb
Date: Fri, 19 Dec 2003 19:24:36 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312191924.36691.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have integrated powerpc kgdb from TimeSys Linux into mainline kgdb at 
http://kgdb.sourceforge.net/ into kgdb for Linux kernel 2.4.23.

It has been integrated with x86 kgdb, hence all features of x86 kgdb are 
available including thread support.

I don't have powerpc hardware to test it, so any problem reports and fixes to 
make it really work are most welcome!!
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

