Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTFVG6R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 02:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTFVG6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 02:58:17 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:53469 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S261773AbTFVG6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 02:58:16 -0400
Message-ID: <3EF556D0.5060900@Synopsys.COM>
Date: Sun, 22 Jun 2003 09:12:16 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21: USB Mass Storage data integrity not assured?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This morning I tried to attach an 2.5" HD via USB2.0 to my Linux box.
I got a message

	WARNING: USB Mass Storage data integrity not assured

in kern.log, followed by billions of IO errors during mkfs.


Well, I need a mass storage whose integrity _is_ assured. Is there
any hope that ehci and usb-storage get improved for a 2.4.x kernel?
Any patches I could try?


Regards

Harri

