Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbUBCTXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUBCTXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:23:35 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:55680 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S266100AbUBCS04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:26:56 -0500
Subject: Oopses with both recent 2.4.x kernels and 2.6.x kernels
From: Stian Jordet <liste@jordet.nu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1075832813.5421.53.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 19:26:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a server which was running 2.4.18 and 2.4.19 for almost 200 days
each, without problems. After an upgrade to 2.4.22, the box haven't been
up for 30 days in a row. This happened early november. I have caputered
oopses with both 2.4.23 and 2.6.1 which I have sent decoded to the list,
but have never got any reply.

I have ran memtest86 on the box, no errors. What else can be the
problem? I could of course go back to 2.4.19, which I know worked fine,
but I there have been some fixed security holes since then...

Any thoughts?

Best regards,
Stian

