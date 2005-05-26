Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVEZBAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVEZBAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 21:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEZBAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 21:00:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:30351 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261625AbVEZBAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 21:00:22 -0400
X-Authenticated: #14640924
Message-ID: <013d01c5618f$2939d240$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: maximum of 256 loop devices - not enough for cdrom server
Date: Thu, 26 May 2005 03:06:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !
I want to build a cd-rom server and want to use the loop-driver (loop.c) for that.
That server will be HUGE and I will need to loopback mount more than 256 .iso images in the near future.
Unfortunately, the loop driver doesn`t support >256 device nodes.

Is there a possible solution for this "problem" ?

regards
roland

