Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbTHGUxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270993AbTHGUxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:53:51 -0400
Received: from ns1.citynetwireless.net ([209.218.71.4]:2567 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S270988AbTHGUx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:53:29 -0400
Message-ID: <00bc01c35d25$748c22e0$0500000a@bp>
From: "Ro0tSiEgE LKML" <lkml@ro0tsiege.org>
To: <linux-kernel@vger.kernel.org>
Subject: no exec after kernel bootup on Elan
Date: Thu, 7 Aug 2003 15:49:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have kernel 2.4.21 on a Soekris net4521 (Elan SC520), and after the kernel
finishes booting up, (when it's supposed to exec init or whatever program I
specify), nothing happens, I get no output past the line "Freeing unused
kernel memory: 120k free".

I get the same results with any program I specify, whether static and
dynamically compiled.


