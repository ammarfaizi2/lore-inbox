Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266443AbUHIKbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUHIKbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUHIKbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:31:18 -0400
Received: from jpwserver.com ([217.160.248.61]:57751 "EHLO
	u15149502.onlinehome-server.com") by vger.kernel.org with ESMTP
	id S266443AbUHIKbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:31:16 -0400
From: "ken" <ken@siam-wireless.com>
To: <linux-kernel@vger.kernel.org>
Subject: Disabling route cache
Date: Mon, 9 Aug 2004 02:28:18 +0800
Message-ID: <000701c47d75$7f529260$8001a8c0@CPQ31353534830>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am building Linux routers with multiple DSL WAN links. I'm using
iproute2 to load balance users onto the Internet. However, with IP route
cache the result is sometimes poor. Is there a way to disable route
caching in the kernel.

						Thanks, Ken


