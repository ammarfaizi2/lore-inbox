Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286354AbRLTTzJ>; Thu, 20 Dec 2001 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286357AbRLTTy7>; Thu, 20 Dec 2001 14:54:59 -0500
Received: from ares.sot.com ([195.74.13.236]:17674 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S286354AbRLTTyk>;
	Thu, 20 Dec 2001 14:54:40 -0500
Date: Thu, 20 Dec 2001 21:54:38 +0200 (EET)
From: Yaroslav Popovitch <yp@sot.com>
To: linux-kernel@vger.kernel.org
Subject: PM: What do this messages describe?
In-Reply-To: <Pine.LNX.4.10.10111071706080.31120-100000@ares.sot.com>
Message-ID: <Pine.LNX.4.10.10112202150070.27092-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dec 20 12:11:19 test1 kernel: Uhhuh. NMI received for unknown reason 3d.
Dec 20 12:11:19 test1 kernel: Dazed and confused, but trying to continue
Dec 20 12:11:19 test1 kernel: Do you have a strange power saving mode
enabled?
Dec 20 12:11:53 test1 kernel: Uhhuh. NMI received for unknown reason 2d.
Dec 20 12:11:53 test1 kernel: Dazed and confused, but trying to continue
Dec 20 12:11:53 test1 kernel: Do you have a strange power saving mode
enabled?    

Is something really wrong? Can be this caused by such options:
[*] Power Management support                                       
   [ ]   ACPI support
   < >   Advanced Power Management BIOS support

Kernel-2.4.12

THX,YP

-
Mr. Yaroslav Popovitch yp@sot.com       - tel. +372 6419975
SOT Finnish Software Engineering Ltd.   - fax  +372 6419975
Kreutzwaldi 7-4, 10124  TALLINN         - http://www.sot.com
ESTONIA                                 - http://bestlinux.net

