Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262240AbTCPCvM>; Sat, 15 Mar 2003 21:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbTCPCvM>; Sat, 15 Mar 2003 21:51:12 -0500
Received: from mpls-qmqp-03.inet.qwest.net ([63.231.195.114]:27662 "HELO
	mpls-qmqp-03.inet.qwest.net") by vger.kernel.org with SMTP
	id <S262240AbTCPCvL>; Sat, 15 Mar 2003 21:51:11 -0500
Date: Sat, 15 Mar 2003 20:59:16 -0800
Message-ID: <002401c2eb78$cca714e0$d5bb0243@oemcomputer>
From: "Paul Albrecht" <palbrecht@uswest.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4 vm, program load, page faulting, ...
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... Why does the kernel page fault on text pages, present in the page cache,
when a program starts? Couldn't the pte's for text present in the page cache
be resolved when they're mapped to memory?

