Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269745AbTGKBTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269746AbTGKBTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:19:18 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:9378 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269745AbTGKBTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:19:16 -0400
From: imunity@softhome.net
To: linux-kernel@vger.kernel.org
Subject: DEVPTS Fatal error to many file types mounted. All 2.5 kernels
Date: Thu, 10 Jul 2003 19:33:58 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [216.3.8.130]
Message-ID: <courier.3F0E1406.00003C8A@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the INIT phase after the inital kernel bootup! 

I am using RH 9.0 on a Dell Laptop c840 Latitude. 

Is this devpts not part of the 2.5 kernels?  Maybe I need to remove it from 
the modules.conf file in the /etc dir? 


WHat has Happened to the "modversions.h" file in the 2.5 kernels.  Some 
applications need that source file in order to compile correctly!!
