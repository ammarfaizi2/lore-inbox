Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbUFDPkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUFDPkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUFDPkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:40:49 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:7439 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265824AbUFDPkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:40:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: 2xPS2 -> USB converter works flawlessly
Date: Fri, 4 Jun 2004 14:38:53 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200406041438.53314.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never used USB devices under Linux, and barely used them
at all. But couple of days ago a friend of mine gave
me almost for free a mobo with fried PS2 mouse and
keyboard ports.

I bought 2xPS2 -> USB converter, compiled in USB
and USB HID support in 2.6.7-rc1-bk2 and you know what?
It works! Both keyboard and mouse! Even in X!

Mega thanks to Greg KH <greg@kroah.com> and other USB
and hotplug folks!
-- 
vda
