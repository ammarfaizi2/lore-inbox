Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTL1Cih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTL1CgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:36:15 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:31949 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S264934AbTL1CeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:34:10 -0500
Message-ID: <173d01c3cceb$08c0cda0$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: What is MCE?
Date: Sun, 28 Dec 2003 11:33:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes:
MCE: The hardware reports a non fatal, correctable incident occurred on CPU
0.
Bank 3: e20000000002010a

Sometimes:
MCE: The hardware reports a non fatal, correctable incident occurred on CPU
0.
Bank 3: a200000000080a01

Obviously this isn't a Linux error, Linux is being kind enough to report a
hardware error to me, but I don't know how to interpret these error flags.
I don't even know what MCE is but whoever developed it for Linux surely must
know.  Please, how can I find out what this is?

