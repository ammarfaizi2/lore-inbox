Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTEaEUE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 00:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTEaEUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 00:20:04 -0400
Received: from [203.152.128.21] ([203.152.128.21]:7830 "EHLO emmtel.com")
	by vger.kernel.org with ESMTP id S264138AbTEaEUE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 00:20:04 -0400
MIME-Version: 1.0
Message-Id: <3ED8306B.000003.01156@virender.internal.com>
Date: Sat, 31 May 2003 10:02:43 +0530
Content-Type: Text/Plain; charset=US-ASCII
X-Mailer: IncrediMail 2001 (2001107.2001107)
From: "Suryakant Verma" <suryakant.verma@drishinfo.com>
X-FID: PLAINTXT-NONE-0000-0000-000000000000
X-FVER: 3.0
X-CNT: ;
Content-Transfer-Encoding: 7BIT
X-Priority: 3
To: <linux-kernel@vger.kernel.org>
Subject: Error:Undefined reference to deflateinit_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 am developing linux kernel 2.4 for uCdimm using CygWin package.
I am trying to put JFFS2 file system support in my kernel.I have enabled =
the JFFS2 support and also the option for MTD UTILS.When build the =
kernel using make i get the following error
Error:Undefined reference to deflateinit_
I try to solve the problem by installing zlib but problem remains kindly =
help me
 