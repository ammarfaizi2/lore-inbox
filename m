Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVA2UrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVA2UrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVA2UrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:47:19 -0500
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:50441 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S261433AbVA2UrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:47:11 -0500
Date: Sun, 30 Jan 2005 09:47:06 +1300
From: ych43 <ych43@student.canterbury.ac.nz>
Subject: adding process data to file descriptor structure
To: linux-kernel@vger.kernel.org
Message-id: <41F2BA32@webmail>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.61
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-WebMail-UserID: ych43
X-EXP32-SerialNo: 00002797
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  In current linux kernel, file descriptors do not include a process data. So 
if it is possible to add process data to file descriptor structures in Linux 
kernel. So a file descriptor could save a list of proc pointers or a list of 
PID values. If this list can be implemented, then sockets can be easily 
identified using protocol control block hash table.
 thanks


