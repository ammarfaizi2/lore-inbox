Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVA0ClY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVA0ClY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVA0ChR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 21:37:17 -0500
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:42765 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S261981AbVA0CeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 21:34:07 -0500
Date: Thu, 27 Jan 2005 15:33:49 +1300
From: ych43 <ych43@student.canterbury.ac.nz>
Subject: how to check the validity of a running daemon on Linux
To: linux-kernel@vger.kernel.org
Message-id: <41F0CDD6@webmail>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.61
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-WebMail-UserID: ych43
X-EXP32-SerialNo: 00002797
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Does anybody know how to check the validity of a deamon. which runs on Linux 
-platform host . This daemon can save some information in a log file of the 
host. I mean that if an attacker compromises this host and gets root access, 
he can replace this daemon with a rogue version. Therfefore, the information 
saved on the log file is incorrect. So how can I check the validity of the 
daemon to show this  daemon is correct version and not a rogue version. So I 
trust the information saved on the host.
  Cheers


