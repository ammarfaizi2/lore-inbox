Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbSKUV1k>; Thu, 21 Nov 2002 16:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264810AbSKUV1k>; Thu, 21 Nov 2002 16:27:40 -0500
Received: from mail.webmaster.com ([216.152.64.131]:63477 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264808AbSKUV1k> convert rfc822-to-8bit; Thu, 21 Nov 2002 16:27:40 -0500
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Thu, 21 Nov 2002 13:34:46 -0800
Subject: TCP memory pressure question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20021121213447.AAA4864@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	When a Linux machine has reached the tcp_mem limit, what will happen to 
'write's on non-blocking sockets? Will they block until more TCP memory is 
available? Will they return an error code? ENOMEM?

	If it varies by kernel version, details about different versions would be 
extremely helpful. I'm most interested in late 2.4 kernels.

	Thanks in advance.

	DS

-- 
David Schwartz
<davids@webmaster.com>


