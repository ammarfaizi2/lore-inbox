Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVAaEMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVAaEMv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 23:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVAaEMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 23:12:51 -0500
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:35083 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S261911AbVAaEMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 23:12:50 -0500
Date: Mon, 31 Jan 2005 17:12:47 +1300
From: ych43 <ych43@student.canterbury.ac.nz>
Subject: adding process data to file descriptor structure in Linux
To: linux-kernel@vger.kernel.org
Message-id: <41F3DE9D@webmail>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.61
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-WebMail-UserID: ych43
X-EXP32-SerialNo: 00002797
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  If it is possible to add some process data to a file descriptor structure in 
Linux? So the file descriptor could either save a list of proc pointers or a 
list of PID values. It this list could be made, then sockets could be easily 
identified using process control block hash table. Does anybody know if it is 
possible?
 thanks


