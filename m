Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbSKXE0l>; Sat, 23 Nov 2002 23:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbSKXE0l>; Sat, 23 Nov 2002 23:26:41 -0500
Received: from smtp.comcast.net ([24.153.64.2]:57150 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267153AbSKXE0l>;
	Sat, 23 Nov 2002 23:26:41 -0500
Date: Sun, 24 Nov 2002 00:45:37 -0500
From: Jerry McBride <mcbrides9@comcast.net>
Subject: LEX = flex
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <0H6200FDECOBEI@mtaout05.icomcast.net>
Organization: TEAM LINUX
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.8; )
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-message-flag: Join the Wave and install Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It's an old one... and it's STILL HERE!

2.4.20-rc3... 

make kernel on i386 fails in /drivers/scsi/aic7xxx/aicasm/Makefile

LEX is not assigned a value... 

However making LEX=flex works and make modules completes 100%... 

Where is this failing to be set?

-- 

******************************************************************************
                     Registered Linux User Number 185956
          http://groups.google.com/groups?hl=en&safe=off&group=linux
             Join me in chat at #linux-users on irc.freenode.net
     11:42pm  up 1 day,  1:15,  3 users,  load average: 0.23, 0.31, 0.24
