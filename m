Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbTIGDf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 23:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTIGDf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 23:35:28 -0400
Received: from beta.EECS.CWRU.Edu ([129.22.150.110]:12268 "EHLO
	beta.eecs.cwru.edu") by vger.kernel.org with ESMTP id S262518AbTIGDfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 23:35:22 -0400
Message-ID: <1062905720.3f5aa77879eba@eecs.cwru.edu>
Date: Sat,  6 Sep 2003 23:35:20 -0400
From: William Sherwin <wgs3@po.cwru.edu>
To: linux-kernel@vger.kernel.org
Subject: Ran out of input data: System Halted
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To Whom It May Concern:

I rebuilt my kernel (2.4.22) yesterday, and when I rebooted, I
got the following screen:

Uncompressing linux...

...ran out of input data.

-- System halted.

At that point, even the keyboard was frozen; I had to power down
my computer by pressing the switch instead of rebooting with
CTRL+ALT+DEL.  I had been running a 2.4.22 kernel when I built
the new kernel; however, I enabled the following options between
builds:

Modules: check version information
BSD process accounting
Check for stack overflows
Compile kernel with frame pointers

I am posting my config file at:

http://home.cwru.edu/~wgs3/.config

Please cc: me in any replies, as I'm not subscribed to the list.

Thank you very much in advance.

William
-- 
William Sherwin
Graduate Student
Department of Physics
Washington University in St. Louis
http://hbar.wustl.edu/~wsherwin/
