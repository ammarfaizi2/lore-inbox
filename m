Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbTCZXNR>; Wed, 26 Mar 2003 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbTCZXNR>; Wed, 26 Mar 2003 18:13:17 -0500
Received: from [208.178.183.22] ([208.178.183.22]:41490 "EHLO
	xout2-dmz.simpletech.com") by vger.kernel.org with ESMTP
	id <S262625AbTCZXNQ> convert rfc822-to-8bit; Wed, 26 Mar 2003 18:13:16 -0500
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: page size bigger than 4 KB for ext2
Date: Wed, 26 Mar 2003 15:24:23 -0800
Message-ID: <E3738FB497C72449B0A81AEABE6E713C027904@STXCHG1.simpletech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: setfs[ug]id syscall return value and include/linux/security.h question
thread-index: AcLz7hy8WdudAjJITPaoyiwgd7kaCwAACKmw
From: "Jordi Ros" <jros@xiran.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Mar 2003 23:24:23.0500 (UTC) FILETIME=[D5D3F8C0:01C2F3EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to bring up a hard drive formated to 8KB page size using ext2. It seems that i may need to recompile the kernel, as default PAGE_SIZE is 4KB. I have 2 questions:

1) What is the procedure to build a kernel that can support hard drives formatted to 8KB ext2?
2) What is the procedure to format a hard drive to 8KB ext2?

Thank you so much,

Jordi
