Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUG3DOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUG3DOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 23:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUG3DOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 23:14:10 -0400
Received: from [218.1.67.73] ([218.1.67.73]:21425 "EHLO trust-mart.com")
	by vger.kernel.org with ESMTP id S267526AbUG3DOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 23:14:07 -0400
Message-ID: <006701c475e3$43a85db0$0d7e12ac@hv>
From: "hv" <hv@trust-mart.com>
To: <linux-kernel@vger.kernel.org>
Subject: 
Date: Fri, 30 Jul 2004 11:14:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.181
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,everyone:
      I have a strange problem about pty's number.
      When I telnet or rsh into my server,I get a failed with message "All
network ports in use." But when I execute "sysctl -a|grep pty",the result I
getting is "kernel.pty.nr=3D267  kernel.pty.max=3D999" (999 is my setting
value).
     Could anybody tell my why?

