Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbTCWLm5>; Sun, 23 Mar 2003 06:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263033AbTCWLm5>; Sun, 23 Mar 2003 06:42:57 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:47032 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263032AbTCWLm4>; Sun, 23 Mar 2003 06:42:56 -0500
Message-Id: <4.3.2.7.2.20030323124058.00b6bbd0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 23 Mar 2003 12:55:16 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: L1_CACHE_SHIFT again
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	According to the Intel docs, the cacheline for a P4 is
	64 bytes. The P4 does, on read, 2 sectors of 64 bytes.
	But, on write, 64 bytes.
	So, is the cache line size wrong ? (7 in 2.4 and 2.5)
	
	Margit 

