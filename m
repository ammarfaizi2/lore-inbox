Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVB1PzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVB1PzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVB1Pyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:54:52 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:8153 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261661AbVB1Pyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:54:38 -0500
Date: Mon, 28 Feb 2005 21:24:52 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: user space program from keyboard driver
Message-ID: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai all,
    I am a newbie to kernel, I want to work on linux kernel modules.
My task is to call a user program from keyboard driver under certain 
conditions. I know that we can call user program using 
call_usermodehelper(), but we can not call it direcly from driver as it is 
a interrupt context. So we need to call using schedule_work(). But I need 
more clarification on these points. How to call user program from the 
keyboard driver. Please give ur ideas for doing this.

Any small help is appreciated.


Please cc ur replies to my mail id.


   Thanks&Regards,

   P.Manohar,


