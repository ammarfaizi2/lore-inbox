Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132407AbRDMXfH>; Fri, 13 Apr 2001 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbRDMXe5>; Fri, 13 Apr 2001 19:34:57 -0400
Received: from [24.70.141.118] ([24.70.141.118]:45552 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S132407AbRDMXen>;
	Fri, 13 Apr 2001 19:34:43 -0400
Date: Fri, 13 Apr 2001 19:34:41 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: OOM killer *WORKS* for a change!
Message-ID: <Pine.LNX.4.33.0104131932260.1502-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just ran netscape which for some reason or another went totally
whacky and gobbled RAM.  It has done this before and made the box
totally unuseable in 2.2.17-2.2.19 befor the kernel killed 90% of
my running apps before getting the right one.  This time, it
OOM'd and killed Netscape and I got control back instantly.  This
is with 2.4.2.  I hope this is a good sign!



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

