Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTIECzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 22:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbTIECzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 22:55:54 -0400
Received: from ns1.citynetwireless.net ([209.218.71.4]:22279 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S262052AbTIECzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 22:55:53 -0400
Message-ID: <005401c37359$e6c30550$20f6d618@bp>
From: "Brad Parker" <parker@citynetwireless.net>
To: <linux-kernel@vger.kernel.org>
Subject: programming with /proc functions
Date: Thu, 4 Sep 2003 22:00:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I find out what I need to change for a module (which creates a /proc
entry) I wrote for 2.2 to work under 2.4, meaning, things like
proc_register[_dynamic], proc_unregister etc. are gone now, how do I go
about figuring out what all needs to be changed?

Thanks

--
Brad Parker



