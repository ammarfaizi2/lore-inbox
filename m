Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTLQWNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbTLQWNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:13:05 -0500
Received: from chico.cs.colostate.edu ([129.82.45.30]:33205 "EHLO
	chico.cs.colostate.edu") by vger.kernel.org with ESMTP
	id S264565AbTLQWND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:13:03 -0500
X-WebMail-UserID: jshankar@cs.colostate.edu
Date: Wed, 17 Dec 2003 15:13:02 -0700
From: jshankar <jshankar@CS.ColoState.EDU>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00002247, 00002264
Subject: ext3 file system
Message-ID: <3FF129DA@webmail.colostate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Infinite Mobile Delivery (Hydra) SMTP v3.62.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does the  ext3 file systems have to wait for the acknowledgement of block of 
data written to the SCSI device before writing the next block of data.

Is there a parallel I/O where the file system goes on writing the block of 
data
without waiting for the acknowledgement.

Please let me know your opinion.

Thanks
Jayshankar

