Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUG3DgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUG3DgC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 23:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUG3DgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 23:36:02 -0400
Received: from [218.1.67.73] ([218.1.67.73]:29105 "EHLO trust-mart.com")
	by vger.kernel.org with ESMTP id S264815AbUG3DgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 23:36:00 -0400
Message-ID: <007101c475e5$63316a80$0d7e12ac@hv>
From: "hv" <hv@trust-mart.com>
To: <linux-kernel@vger.kernel.org>
Subject: tty's problem
Date: Fri, 30 Jul 2004 11:29:14 +0800
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

