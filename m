Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbUKGQ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUKGQ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUKGQ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:58:25 -0500
Received: from mail.lenhof.eu.org ([82.224.168.19]:14086 "EHLO
	www.lenhof.eu.org") by vger.kernel.org with ESMTP id S261652AbUKGQ6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:58:16 -0500
Subject: Problem with USB 1.1 Storage plugged in USB 2.0
From: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099846698.6045.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 07 Nov 2004 17:58:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel folks,

I just enter this bug because I want to buy a new laptop and very often
there's only USB 2.0 port on new ones...

Quickly my problem :
I try to mount as a usb-storage my Minolta DiMAGE F200 (which seems to
be USB
1.1)  on a kernel 2.6

If I plug it on a USB 2.0 plug, it hangs
If I plug it on a USB 1.1 plug, it works

With kernel 2.4 (module usb-uhci) it works whatever the plug I use.

I've posted more information there :
http://bugme.osdl.org/show_bug.cgi?id=3711

If there's a patch around or something that I can test, ask.

Thanks for your job.

PS : Please cc me as I'm not on the list

-- 
Jean-Yves LENHOF <jean-yves@lenhof.eu.org>

