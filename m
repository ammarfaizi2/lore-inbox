Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbTCRAle>; Mon, 17 Mar 2003 19:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262064AbTCRAle>; Mon, 17 Mar 2003 19:41:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262062AbTCRAld>;
	Mon, 17 Mar 2003 19:41:33 -0500
Subject: Re: Linux 2.5.65
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047948785.3844.151.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 17 Mar 2003 16:53:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.65


                               2.5.64               2.5.65
                       --------------------    -----------------
bzImage (defconfig)         14 warnings          14 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      30 warnings          30 warnings
                             9 errors            12 errors

modules (allmodconfig)    2356 warnings        2421 warnings
                            99 errors           100 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.65
at: www.osdl.org/archive/cherry/stability  (will be updated by 6PM PST).



Other stability-related links:
   OSDL Stability page:
       http://osdl.org/projects/26lnxstblztn/results/
   Nightly linux-2.5 bk build:
       www.osdl.org/archive/cherry/stability/linus-tree/running.txt
   2.5 porting items:
       www.osdl.org/archive/cherry/stability/linus-tree/port_items.txt
   2.5 porting items history:
       www.osdl.org/archive/cherry/stability/linus-tree/port_history.txt

John

