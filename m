Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVLAXMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVLAXMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVLAXMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:12:47 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:11149 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932554AbVLAXMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:12:46 -0500
Message-ID: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc3: adduser: unable to lock password file
Date: Thu, 1 Dec 2005 23:47:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I get this after upgrade from 2.6.14.2

[root@dy-xeon-1 etc]# adduser someuser
adduser: unable to lock password file
[root@dy-xeon-1 etc]#

I use nfsroot!

Thanks

Janos

