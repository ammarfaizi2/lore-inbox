Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTBRAlQ>; Mon, 17 Feb 2003 19:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbTBRAlQ>; Mon, 17 Feb 2003 19:41:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267162AbTBRAlP>;
	Mon, 17 Feb 2003 19:41:15 -0500
Subject: Re: Linux v2.5.62
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045510507.3406.12.camel@cherrypit.pdx.osdl.net>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
	 <1045510507.3406.12.camel@cherrypit.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1045529534.24088.60.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 16:52:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.62

Note that gcc 3.2 was used for all of these statistics. 

                               2.5.61               2.5.62
                       --------------------    -----------------
bzImage (defconfig)         19 warnings          18 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      33 warnings          33 warnings
                             9 errors             9 errors

modules (allmodconfig)    2531 warnings        2514 warnings
                           176 errors           105 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.62
at: www.osdl.org/archive/cherry/stability

John

