Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUBKOh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBKOh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:37:59 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:46019 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265346AbUBKOhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:37:53 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: CVS repository for kgdb
Date: Wed, 11 Feb 2004 20:07:18 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402112007.18036.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have setup a cvs repository for kgdb at sourceforge. Those who plan to 
contribute to kgdb on a regular basis, feel free become add yourself as 
developers to this project and checkin changes yourself.

Here is cvs access information for users of kgdb:

kgdb project page includes instructions for accessing kgdb cvs tree. Here is a 
quick download guide for users of kgdb.

cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/kgdb login
 
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/kgdb co .

These instructions will fetch latest kgdb development version in current 
directory. The directory kgdb-2 contains kgdb for 2.6 kernels. For further 
updates, go to the same directory and run cvs update

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

