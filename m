Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUDTSuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUDTSuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbUDTSuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:50:32 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38668 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263656AbUDTSub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:50:31 -0400
Message-ID: <40857175.9080806@techsource.com>
Date: Tue, 20 Apr 2004 14:52:37 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: System hang with ATI's lousy driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, since XFree86's lousy open-source Radeon driver won't do OpenGL 
right, I am forced to use ATI's lousy proprietary Radeon driver.  With 
that, I can do OpenGL right, but when I exit the X server, the system 
hangs completely.  I get lots of vertical lines on the screen, but I 
can't even ping the computer.

Does anyone know of any conflict between using ATI's X11 driver and the 
Radeon console driver at the same time?

I'm using kernel gentoo-2.4.25.


I'm getting really sick of not being able to get new graphics cards to 
just work properly under Linux.


Thanks.

