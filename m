Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSJRCRo>; Thu, 17 Oct 2002 22:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSJRCRo>; Thu, 17 Oct 2002 22:17:44 -0400
Received: from smtp.comcast.net ([24.153.64.2]:5218 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S262789AbSJRCRn>;
	Thu, 17 Oct 2002 22:17:43 -0400
Date: Thu, 17 Oct 2002 22:22:03 -0400
From: Jerry McBride <mcbrides9@comcast.net>
Subject: LEX = flex
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <0H4500IQMNZE4K@mtaout05.icomcast.net>
Organization: TEAM LINUX
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.8; )
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-message-flag: Join the Wave and install Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's an old one... and it's BACK. 2.4.20-pre11... make kernel on i386 fails in
/drivers/scsi/aic7xxx/aicasm/Makefile

LEX is not assigned a value... 

However making LEX=flex works and make modules completes 100%... 

Where is this failing to be set?

-- 

******************************************************************************
                     Registered Linux User Number 185956
          http://groups.google.com/groups?hl=en&safe=off&group=linux
             Join me in chat at #linux-users on irc.freenode.net
    10:02pm  up 219 days,  3:11,  6 users,  load average: 0.29, 0.25, 0.21
