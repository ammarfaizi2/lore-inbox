Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSHBDWv>; Thu, 1 Aug 2002 23:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSHBDWv>; Thu, 1 Aug 2002 23:22:51 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:48088 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317980AbSHBDWv>; Thu, 1 Aug 2002 23:22:51 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
Date: Wed, 31 Jul 2002 23:30:31 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207312330.31101.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following trivial patches are still missing from the kernel:

	 - devfs patch to fix the problem with missing virtual consoles - only 0 in 
/dev/vc: drivers/char/console.c

	 - patch to drivers/acpi/system.c, adding a missing include...
			I believe it was interrupt.h







