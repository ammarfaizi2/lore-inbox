Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUHEH3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUHEH3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUHEH3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:29:47 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59044 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267591AbUHEH3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:29:45 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: 16TB filesystems on 2.6 via NFSD?
Date: Thu, 5 Aug 2004 00:30:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcR6vhcbVihUkmJyTzC2Tago7jgjTA==
Message-Id: <S267591AbUHEH3p/20040805072945Z+687@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at moving beyond 1.5-2TB limitations in 2.4 and RHEL3 by 
using a 2.6 kernel. I have read that the filesystems scale to 16TB in 2.6, 
I just want to verify that nfsd will scale along with the filesystem to 16TB
as well.
 
Also, I would love to hear any opinions around performance/stability 
of going beyond 2TB filesystems on the 2.6 kernel.

Thanks in advance,
 
--Buddy


