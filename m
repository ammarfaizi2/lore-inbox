Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTIQGyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 02:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbTIQGyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 02:54:23 -0400
Received: from [211.192.194.130] ([211.192.194.130]:58545 "EHLO mail.inzen.com")
	by vger.kernel.org with ESMTP id S262690AbTIQGyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 02:54:22 -0400
From: "Kim, Hyunchul" <kimhc@inzen.com>
To: <linux-kernel@vger.kernel.org>
Subject: When does a general protection fault occur?
Date: Wed, 17 Sep 2003 15:54:20 +0900
Message-ID: <001801c37ce8$85712eb0$0122030a@kimhc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
 
I'm studying non-executable stack patch.
It modified do_general_protection(), the general protection fault
handler(?).
I wanna know when the handler is called, or where could I find it.
 
Thanks in advance.
 

