Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUKADdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUKADdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 22:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKADdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 22:33:54 -0500
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:26631 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S261731AbUKADdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 22:33:53 -0500
Date: Mon, 01 Nov 2004 16:33:49 +1300
From: ych43 <ych43@student.canterbury.ac.nz>
Subject: TCP port numbers
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <41838517@webmail>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.61
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-WebMail-UserID: ych43
X-EXP32-SerialNo: 00002797
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I got one question about unix socket functions. I have two machines (called A 
and B). I use A to telnet B, get the root password of B. Is there any unix 
socket function I can use to get the port number of A on B. Obviously, the 
port number of B is 23. I want to use a socket function implemented on B to 
get the port number of A because a TCP connection is established between them.
  I greatly appreciate it if you help me. Thank you in advance.
  Xue

