Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWFPKyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWFPKyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 06:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWFPKyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 06:54:45 -0400
Received: from orange.blizznet.at ([213.143.111.1]:34504 "EHLO
	orange.hybridz.net") by vger.kernel.org with ESMTP id S1751193AbWFPKyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 06:54:45 -0400
From: "Ralf Dauberschmidt" <rfk@digitalstyle.de>
To: <linux-kernel@vger.kernel.org>
Subject: sock_alloc() symbol removed in 2.6.10
Date: Fri, 16 Jun 2006 12:54:33 +0200
Message-ID: <000f01c69133$41114bd0$0200000a@redstorm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcaRMz3hM2GWjMGPRB6cOAVPpS5kSA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As of kernel 2.6.10 the symbol export of the sock_alloc() function has been
removed (I assume in the course of "Remove dead socket layer exports"). Can
anybody tell me why this happened? Why is it "dead"?

Thanks in advance.

Regards,
 Ralf Dauberschmidt

