Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSI2V3Q>; Sun, 29 Sep 2002 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSI2V3Q>; Sun, 29 Sep 2002 17:29:16 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:39151 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261669AbSI2V3P>; Sun, 29 Sep 2002 17:29:15 -0400
Message-ID: <2535278.1033335071848.JavaMail.nobody@web54.us.oracle.com>
Date: Sun, 29 Sep 2002 14:31:11 -0700 (PDT)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39: Oracle 9.2 goes OOM on startup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The startup procedure doesn't complete anymore, and the kernel kills the starting
 process due to OOM. Having been away 2 weeks I can only say that

 2.5.34 works
 2.5.38 OOMs
 2.5.39 OOMs

If nobody has an idea what i should try, i'll build the missing kernels and see at
 what point exactly the 9.2 boot process gets killed by OOM.

Thanks & ciao,

--alessandro
