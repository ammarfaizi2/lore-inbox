Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWH2IMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWH2IMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWH2IMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:12:52 -0400
Received: from mail.kingsoft.net ([211.152.52.46]:7249 "HELO mail.kingsoft.net")
	by vger.kernel.org with SMTP id S1751268AbWH2IMv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:12:51 -0400
From: =?UTF-8?B?TGltZW5nIFvmnY7okIxd?= <avlimeng@kingsoft.net>
To: <linux-kernel@vger.kernel.org>
Subject: help
Date: Tue, 29 Aug 2006 16:12:18 +0800
Message-ID: <004a01c6cb42$dbdbc110$8940a8c0@liibook>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbLQthDL1kMIts/Ty+iHwxe7Wbq2Q==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    How can I get one thread’s  LWP id on linux？ 
    The thread is not the main thread, so that getpid() does not work. And the LWP id is not the same as the result by pthread_self().

    Any suggestion?

Xixi
2006-8-29


