Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTEPFW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTEPFW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:22:56 -0400
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:49164 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S264123AbTEPFW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:22:56 -0400
Message-ID: <001601c31b6d$a2dc7d10$0201a8c0@homedomain.priv>
From: "Mark Tranchant" <mark@tranchant.freeserve.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Documentation fix
Date: Fri, 16 May 2003 06:39:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo in line 55 of Documentation/networking/3c509.txt (ref
2.4.20 and 2.5.59). It should read:

   options 3c509 xcvr=3,1 irq=10,11

rather than xcvr=3,3.

David Ruggiero (the maintainer listed in the file) says he's not the
maintainer any more.

--
Mark.
mark@tranchant.freeserve.co.uk
http://www.tranchant.freeserve.co.uk/

