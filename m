Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTBXWTr>; Mon, 24 Feb 2003 17:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTBXWTr>; Mon, 24 Feb 2003 17:19:47 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261302AbTBXWTq>;
	Mon, 24 Feb 2003 17:19:46 -0500
Subject: Re: Linux 2.5.63
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046125939.18438.99.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 24 Feb 2003 14:32:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.63

Note that gcc 3.2 was used for all of these statistics. 

                               2.5.62               2.5.63
                       --------------------    -----------------
bzImage (defconfig)         18 warnings          15 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      33 warnings          29 warnings
                             9 errors             9 errors

modules (allmodconfig)    2514 warnings        2426 warnings
                           105 errors           128 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.63
at: www.osdl.org/archive/cherry/stability

I am also compiling nightly views of Linus' linux-2.5 bitkeeper tree. 
Results can be found at:

www.osdl.org/archive/cherry/stability/linus-tree/running.txt

John




