Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTFYEHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 00:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTFYEHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 00:07:54 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([24.192.190.108]:15108
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S264178AbTFYEHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 00:07:53 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Subject: Speeding up Linux kernel compiles using -pipe?
Date: Wed, 25 Jun 2003 00:22:13 -0400
Message-ID: <000001c33ad1$5c415ff0$030aa8c0@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why aren't we using -pipe? It can significantly speed up compiles by not
writing temp files (intermediate files).

I don't see harm in adding this?

What do you all think?

Shawn.

