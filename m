Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130864AbRA3XlP>; Tue, 30 Jan 2001 18:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130922AbRA3XlG>; Tue, 30 Jan 2001 18:41:06 -0500
Received: from fe040.world-online.no ([213.142.64.154]:45030 "HELO
	mail.world-online.no") by vger.kernel.org with SMTP
	id <S130864AbRA3Xk6>; Tue, 30 Jan 2001 18:40:58 -0500
From: Ole André Vadla Ravnås 
	<zole@diamondhead.hesbynett.no>
To: linux-kernel@vger.kernel.org
Subject: RAID-cleanups in 2.4.1
Date: Wed, 31 Jan 2001 00:49:09 -0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
MIME-Version: 1.0
Message-Id: <01013100490900.08065@zole.jblinux.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume I'm not the first one to notice, but the RAID-cleanups that made it 
into 2.4.1-pre12 (and thus also the final) resulted in "unresolved symbols" 
when compiling the RAID-stuff as modules (worked fine in 2.4.1-pre11).
Any patches/fixes anyone?

Ole André
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
