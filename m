Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVDOQfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVDOQfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVDOQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:35:10 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:48367 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261860AbVDOQfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:35:05 -0400
Message-ID: <004901c541d9$16b18ad0$6501a8c0@Jaguar>
Reply-To: "Linda Luu" <linda.luu@comcast.net>
From: "Linda Luu" <linda.luu@comcast.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Nguyen, Nguyen \(Home\)" <ndnguyen3@comcast.net>
Subject: Multi-core, Vanderpool support?
Date: Fri, 15 Apr 2005 09:35:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
Does anyone happen to know how the upcoming multi-core CPU will be handled
by the kernel?  Does it see each core as a physical or logical CPU or ?
 
Vanderpool is a hardware support for OS virtualization (running multiple OS
"at the same time"), how does Linux kernel make use of this, particularly
which part of the kernel code? 

I poke around the source (2.6.10) some but haven't figured both issues out
yet.

Many thanks!
Linda

