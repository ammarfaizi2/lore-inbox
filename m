Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVHADXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVHADXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 23:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVHADXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 23:23:16 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:33461 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261980AbVHADXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 23:23:08 -0400
Message-Id: <6.2.3.4.0.20050731211920.0404a8f0@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Sun, 31 Jul 2005 21:23:06 -0600
To: John Stoffel <john@stoffel.org>
From: Jeff Woods <Kazrak+kernel@cesmail.net>
Subject: Re: SCSI tape problems: 2.6.12, DLT 7000, Adaptec AIC7xxx
  controller
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <17133.35430.609291.83377@smtp.charter.net>
References: <17133.35430.609291.83377@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7/31/2005 22:35 -0400, John Stoffel wrote:
>I don't know if this is a problem with the AIC7xxx driver, the tape 
>in the drive, or the DLT7000 drive itself.

Run the DLTsage/Xtalk diagnostics found at http://tinyurl.com/dn7xn 
[which redirects to 
http://www.quantum.com/ServiceandSupport/SoftwareandDocumentationDownloads/DLT7000/Index.aspx#Diagnostics 
].
Note: They have a Linux version there, but I have no personal 
experience with it.

--
Jeff Woods <kazrak+kernel@cesmail.net> 

