Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTFDQBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 12:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTFDQBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 12:01:30 -0400
Received: from ds4.granbury.com ([205.162.53.20]:12559 "EHLO ds4.granbury.com")
	by vger.kernel.org with ESMTP id S263487AbTFDQB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 12:01:29 -0400
From: "Jeremy Salch" <salch@tblx.net>
To: <linux-kernel@vger.kernel.org>
Subject: Access past end of device
Date: Wed, 4 Jun 2003 11:13:02 -0500
Message-ID: <001d01c32ab4$2cb8e320$9fdeae3f@TBLXM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a dell powerall web 120 with scsi drives installed
Using redhat 7.2 with the 2.4.18-19.7.x kernel installed 



And when using badblocks on the swap partition I get

 

 

 

Attempt to access beyond end of device

08:06: rw=0, want=1044196, limit=1044193

1044192

done

Pass completed, 1 bad blocks found.

 

 

And fdisk reports there to be 1044193+ blocks in the partition ?

 

 

I wish to be personally CC'ed any answer / comments..  

 

Thanks a million

 

