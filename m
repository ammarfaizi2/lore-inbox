Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292967AbSCIWQf>; Sat, 9 Mar 2002 17:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292971AbSCIWQZ>; Sat, 9 Mar 2002 17:16:25 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:23872 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S292967AbSCIWQH>; Sat, 9 Mar 2002 17:16:07 -0500
From: brian@worldcontrol.com
Date: Sat, 9 Mar 2002 14:13:41 -0800
To: linux-kernel@vger.kernel.org
Subject: loading ./cryptfs.o will taint the kernel
Message-ID: <20020309221341.GA2533@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loading ./cryptfs.o will taint the kernel: non-GPL license - LGPL


I have long thought that I understood the reasoning behind "taint" and
binary drivers.

However, cryptfs is available with complete source code, so I presume
the "undebug-able" argument doesn't apply.

So what is the big deal?

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
