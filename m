Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTFXKY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTFXKY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:24:26 -0400
Received: from mail.webmaster.com ([216.152.64.131]:10733 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261820AbTFXKYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:24:25 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <vanstadentenbrink@ahcfaust.nl>, <linux-kernel@vger.kernel.org>
Subject: RE: GPL violations by wireless manufacturers
Date: Tue, 24 Jun 2003 03:38:32 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEEDDOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3EF83FAF.24578.38A16F@localhost>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Your product includes a kernel driver module that is  inserted into
> the GPL licensed Linux kernel when the  product is turned on. There
> is no possible way for the user  to prevent the insertion of this
> module into the kernel. It is  also impossible for the user to remove
> the kernel module  from the running kernel. The operation of the
> included  software on your product depends on the operation of the
> kernel module. For these reasons the kernel driver module  is not
> offered as a separate work as described in Section II  of the GPL and
> must therefore be distributed under the  terms and conditions of the
> GPL.

	Perhaps it's not a separate work from the programs that access it, but it's
certainly a separate work from the kernel. The kernel can operate just fine
without the module. The module extends the kernel through a well-defined
boundary.

	The GPL says:

"These requirements apply to the modified work as a whole.  If
identifiable sections of that work are not derived from the Program,
and can be reasonably considered independent and separate works in
themselves, then this License, and its terms, do not apply to those
sections when you distribute them as separate works.  But when you
distribute the same sections as part of a whole which is a work based
on the Program, the distribution of the whole must be on the terms of
this License, whose permissions for other licensees extend to the
entire whole, and thus to each and every part regardless of who wrote it."

	So is a Linux distribution "a whole which is a work based on the" Linux
kernel? Would you argue that RedHat can't include proprietary software on
the same CD as the Linux kernel? All the software on the CD, assuming it's
Linux software, likewise extends the kernel through a well-defined boundary.

	DS


