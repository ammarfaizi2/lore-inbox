Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318064AbSHDBat>; Sat, 3 Aug 2002 21:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318073AbSHDBat>; Sat, 3 Aug 2002 21:30:49 -0400
Received: from smtp.comcast.net ([24.153.64.2]:21566 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S318064AbSHDBas>;
	Sat, 3 Aug 2002 21:30:48 -0400
Date: Sat, 03 Aug 2002 21:39:32 -0400
From: Jerry McBride <mcbrides9@comcast.net>
Subject: Small error in 2.4.19 makefile a real show stopper...
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <20020803213932.61edb001.mcbrides9@comcast.net>
Organization: TEAM LINUX
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.8; )
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-message-flag: Join the Wave and install Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Working with a vanilla 2.4.19 I find that
linux-2.4.19/drivers/scsi/aic7xxx/aicasm/Makefile is not correctly
declaring that "LEX=flex". 



-- 

*************************************************************************
*****
                     Registered Linux User Number 185956
          http://groups.google.com/groups?hl=en&safe=off&group=linux
    9:22pm  up 144 days,  2:31,  7 users,  load average: 0.02, 0.04, 0.00
