Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbTIEXlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTIEXlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:41:52 -0400
Received: from [65.243.131.113] ([65.243.131.113]:58764 "EHLO lapdog.lund.com")
	by vger.kernel.org with ESMTP id S262082AbTIEXlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:41:51 -0400
From: Scott Chapman <scott_list@mischko.com>
Reply-To: scott_list@mischko.com
To: linux-kernel@vger.kernel.org
Subject: Plans for better performance metrics in upcoming kernels?
Date: Fri, 5 Sep 2003 16:41:44 -0700
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051641.44228.scott_list@mischko.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm wondering what the plans are for more accurate and more useful performance 
metrics in upcoming kernels.

CPU Utilization by process is apparently a known-inaccuracy.

There are no disk I/O metrics per process.

CPU Queue Length doesn't appear to be available?

Etc.

Linux clearly falls behind the competition in this area. It makes it rather 
tough to do system performance analysis on a Linux box!  :-)

Is there a plan to deal with these issues?  ETA's?

Cordially,
Scott

