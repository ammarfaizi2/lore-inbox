Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUCWW5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUCWW5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:57:07 -0500
Received: from chico.cs.colostate.edu ([129.82.45.30]:7351 "EHLO
	chico.cs.colostate.edu") by vger.kernel.org with ESMTP
	id S262939AbUCWW5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:57:03 -0500
X-WebMail-UserID: jshankar@cs.colostate.edu
Date: Tue, 23 Mar 2004 15:57:07 -0700
From: jshankar <jshankar@CS.ColoState.EDU>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002247, 00002264
Subject: register ide devices
Message-ID: <4064D7BB@webmail.colostate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Infinite Mobile Delivery (Hydra) SMTP v3.62.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to register an ide device in my driver code. Can i get some 
insight
into the ide-register API and its parameter. Also  do i have to set   the IRQ 
level. I am trying to get the equivalent of scsi_register for ide device.  
What all things i need to  consider?.

Please let me know.

Thanks
Jay

