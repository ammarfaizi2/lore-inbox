Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbTGKBPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbTGKBPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:15:07 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:12264 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S266577AbTGKBPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:15:06 -0400
From: imunity@softhome.net
To: linux-kernel@vger.kernel.org
Subject: USB-UHCI Fatal Error for all 2.5 kernels and 2.5.75 in RedHat v9.0
Date: Thu, 10 Jul 2003 19:29:47 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [216.3.8.130]
Message-ID: <courier.3F0E130B.000035DE@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For soem reason right after the boot of the 2.5 kernels right when the INIT 
starts the USB-UHCI fails for  the HID devices. 

If I reconfigure the kernel without HID it still fails?  Maybe I need to 
modify the modules.conf in the /etc dir or something?
