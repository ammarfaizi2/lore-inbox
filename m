Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268916AbUIXR0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268916AbUIXR0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUIXRZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:25:58 -0400
Received: from web51808.mail.yahoo.com ([206.190.38.239]:1921 "HELO
	web51808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268916AbUIXRYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:24:44 -0400
Message-ID: <20040924151604.30416.qmail@web51808.mail.yahoo.com>
Date: Fri, 24 Sep 2004 08:16:04 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: resource provisioning
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to know if the linux kernel has a
mechanism to control computing resources at a uid
level, which I will call "resource provisioning".  For
example, I would like to define on a multi cpu machine
that a list of uid's can not consume more than 1 cpu
and no more than 1G RAM, irregardless or how many jobs
they launch on or to the system.

So I guess, is this the correct term and is there a
posibilitity to do this now?

I would like to avoid the virtual servers method as I
do not want to carve the machines in question into
more machines.

Thanks for the help!
Phy


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
