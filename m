Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTEOQxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264121AbTEOQxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:53:31 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:24559 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S264120AbTEOQxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:53:31 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Ingo Oeser'" <ingo.oeser@informatik.tu-chemnitz.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
Date: Thu, 15 May 2003 11:04:42 -0700
Organization: Murgatroid.Com
Message-ID: <000301c31b0c$75ff02b0$7900000a@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20030515184738.C626@nightmaster.csn.tu-chemnitz.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this also the case, if I don't want threading at all on my
> system? Does glibc still have a seperate static library for this,
> or should I revert to dietlibc in these cases?

I'm using the most excellent uClibc, which has a configuration option
for POSIX threads.

-ch

