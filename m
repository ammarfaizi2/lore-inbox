Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbTBJWLQ>; Mon, 10 Feb 2003 17:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBJWLQ>; Mon, 10 Feb 2003 17:11:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265378AbTBJWLP>;
	Mon, 10 Feb 2003 17:11:15 -0500
Subject: Re: Linux 2.5.60
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044915711.4852.41.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Feb 2003 14:21:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.60

Note that gcc 3.2 was used for all of these statistics.  gcc 2.95 is
much more lenient on warnings and errors.

                               2.5.59               2.5.60
                       --------------------    -----------------
bzImage (defconfig)         20 warnings          21 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      32 warnings          37 warnings
                             9 errors             9 errors

modules (allmodconfig)    3119 warnings        3079 warnings
                           159 errors           138 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.60
at: www.osdl.org/archive/cherry/stability

John


-- 
John Cherry <cherry@osdl.org>

