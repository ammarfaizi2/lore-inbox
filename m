Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTIBDwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 23:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbTIBDwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 23:52:00 -0400
Received: from h013.c007.snv.cp.net ([209.228.33.241]:34721 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id S263477AbTIBDv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 23:51:59 -0400
X-Sent: 2 Sep 2003 03:51:17 GMT
Message-ID: <005f01c37105$56460370$323be90c@bananacabana>
From: "Chris Peterson" <chris@potamus.org>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: laptop touchpad on linux-2.6.0-test4 
Date: Mon, 1 Sep 2003 20:50:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded a working Redhat 9 installation (linux-2.4.20) to
linux-2.6.0-test4. I can boot and start X and Gnome successfully.
Unfortunately, my laptop's touchpad and mouse "joystick" do not work. My
laptop is a Dell Latitude C400. I have not tried an external mouse because
my laptop does not have an external mouse port.

Using Google, I've found some LKML threads about problems with the Synaptics
touchpad driver and the evdev kernel module, but the threads end before a
verified solution ("it works now. thanks!") is posted. Is there a known fix
for this touchpad problem?

thanks,
chris

