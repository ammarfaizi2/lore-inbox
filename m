Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTBQSxe>; Mon, 17 Feb 2003 13:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTBQSxe>; Mon, 17 Feb 2003 13:53:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52638 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267415AbTBQSxA>;
	Mon, 17 Feb 2003 13:53:00 -0500
Subject: Re: [PATCH] BUG() call in vmalloc.c causes segmentation fault.
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF5C55340D.C61E6D3F-ON05256CD0.00688A5D-86256CD0.006903BF@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Mon, 17 Feb 2003 13:02:48 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 02/17/2003 02:02:53 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention that this patch was against 2.4.21-pre4.

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein


