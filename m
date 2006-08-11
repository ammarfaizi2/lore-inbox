Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWHKEOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWHKEOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 00:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWHKEOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 00:14:04 -0400
Received: from flute.cs.nchu.edu.tw ([140.120.13.3]:35265 "EHLO
	flute.cs.nchu.edu.tw") by vger.kernel.org with ESMTP
	id S1751157AbWHKEN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 00:13:58 -0400
From: "Hsung-Pin Chang" <hpchang@cs.nchu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: Upcall implementation in Linux
Date: Fri, 11 Aug 2006 12:13:41 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: Aca8/IcYD0UTQebORTaoqwQLiP9OEA==
Message-Id: <20060811041650.A0C2C3993@flute.cs.nchu.edu.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                Dear all,

                Recently, I need to use upcalls in Linux to actively and
promptly inform 
                the user applications once an kernel event is occurred.
                However, I have some questions about upcall implementation.
                First, the user handler must be "pinned" into memory to
prevent paging out.
                However, would anyone tell me how to achieve this?
                Second, is there any refernece to upcall implementation for
me to begin?
                Thanks very much.

                Hsung-Pin Chang


