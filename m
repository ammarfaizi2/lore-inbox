Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUBZPbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUBZPbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:31:40 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:6339 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S262126AbUBZPbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:31:34 -0500
Message-ID: <001b01c3fc7d$9e265650$0e25fe96@pysiak>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
Subject: How to use cipher algorithms in the kernel?
Date: Thu, 26 Feb 2004 16:31:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

are the cipher algorithms in the kernel to be used by any userspace
aplication?
eg. I were to write a program that would need to cipher a message, would
it be a good way to try to use something like CONFIG_CRYPTO_CAST5 ?

If so, is there an api explained somewhere?

Regards,
Maciej

