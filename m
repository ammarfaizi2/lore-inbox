Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSLSRzT>; Thu, 19 Dec 2002 12:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLSRzS>; Thu, 19 Dec 2002 12:55:18 -0500
Received: from research.suspicious.org ([198.78.65.136]:33285 "EHLO
	research.suspicious.org") by vger.kernel.org with ESMTP
	id <S265816AbSLSRzS>; Thu, 19 Dec 2002 12:55:18 -0500
Date: Thu, 19 Dec 2002 13:02:42 -0500
From: phil <phil@research.suspicious.org>
To: linux-kernel@vger.kernel.org
Subject: cd access crashes kernel 2.5.52
Message-Id: <20021219130242.3df8248c.phil@research.suspicious.org>
Organization: research.suspicious.org
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This message is in the dmesg, then accessing the cd-rom causes the kernel to crash

scsi HBA driver idescsi didn't set max_sectors, please fix the template
ERROR: SCSI host `ide-scsi' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace: [<c0243eac>]  [<c024c082>]  [<c0243eec>]  [<c010507a>]  [<c0105040>]
  [<c0107129>] 
