Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269412AbUIYVCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269412AbUIYVCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbUIYVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 17:02:55 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:59836 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269412AbUIYVCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 17:02:54 -0400
From: stephan.dreyer@t-online.de (Stephan Dreyer)
To: <linux-kernel@vger.kernel.org>
Subject: Get ip before accept
Date: Sat, 25 Sep 2004 23:02:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcSjQwLfjXRHc73lREa55YGCEDt5cw==
Message-ID: <1CBJgr-2AiaYq0@fwd01.sul.t-online.com>
X-ID: EAE+JoZSYeaPOBmVMHPTMVUHf6FFFB3tuRyzvDBmDZYV1l-BnmYm6N
X-TOI-MSGID: ff43345b-071c-4a20-863f-91ea4406561d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I'm trying to get a client ip before calling accept
Any ideas how?
It should be possible to get ip from connection queue when switching to
kernel space should it?
If ip doesnt't match a given list i want to close the not fully established
connection

Cheers,
Stephan

