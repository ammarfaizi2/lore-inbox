Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTJJIy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTJJIy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:54:56 -0400
Received: from mx.laposte.net ([81.255.54.11]:22580 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S262705AbTJJIyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:54:54 -0400
Message-ID: <3F867398.4050306@users.sourceforge.net>
Date: Fri, 10 Oct 2003 10:53:44 +0200
From: Marc Chalain <marc-chalain@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sitecom (R)  USB-DOCK serial converter driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello every body
I bought a USB-DOCK of Sitecom(R) connectivty. The linux standard usb 
driver support the parallel printer driver, the 2 ps2 connectors and the 
USB-Hub. But the serial converter is not compatible with the linux 
generic USB-Serial driver.
I build a usb-serial driver from the source of the generic usb-serial 
driver, and it seems to work.
Now i'm looking for somebody to try this driver. Can somebody help me?
I created a patch for the kernel 2.4.22.
Thank you.
Marc.

