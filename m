Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUGZIdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUGZIdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUGZIdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:33:24 -0400
Received: from sina35-227.sina.com.cn ([202.108.35.227]:16356 "HELO
	vip.sina.com.cn") by vger.kernel.org with SMTP id S265041AbUGZIdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:33:24 -0400
Message-ID: <20040726083312.8599.qmail@vip.sina.com.cn>
From: <shinepeak@vip.sina.com>
To: linux-kernel@vger.kernel.org
Subject: gethostbyname() return "No such device"
MIME-Version: 1.0
Date: Mon, 26 Jul 2004 16:33:11 +0800
X-Mailer: SinaMail 3.0Beta (FireToad)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
   When I call gethostbyname() to get IP of localhost, it returned NULL, and perror() displayed "No such device". Why? My network was configured correctly.
   Thank you!
______________________________________

===================================================================
