Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTEIIE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTEIIE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:04:59 -0400
Received: from denise.shiny.it ([194.20.232.1]:47558 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262348AbTEIIE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:04:59 -0400
Message-ID: <XFMail.20030509101730.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3EBAD63C.4070808@nortelnetworks.com>
Date: Fri, 09 May 2003 10:17:30 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: RE: how to measure scheduler latency on powerpc?  realfeel doesn
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08-May-2003 Chris Friesen wrote:
> 
> I'm trying to test the scheduler latency on a powerpc platform.  It appears that 
> a realfeel type of program won't work since you can't program /dev/rtc to 
> generated interrupts on powerpc.  Is there anything similar which could be done?

If you are using a legacy Mac, you can use the serial port. If you have
a sound chip, you can use that one. All archs have a programmable timer, even
if /dev/rtc doesn't suport it. Try to ask in the linuxppc-dev mailing list.


Bye.

