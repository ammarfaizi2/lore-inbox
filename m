Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVDESFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVDESFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVDESCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:02:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:11398 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261847AbVDERsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:48:31 -0400
Subject: Re: [SCSI] Driver Broken in 2.6.x (attemp 2)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: |TEcHNO| <techno@punkt.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4252CA25.70803@punkt.pl>
References: <4252CA25.70803@punkt.pl>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 12:48:23 -0500
Message-Id: <1112723304.6463.17.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 19:25 +0200, |TEcHNO| wrote:
> 	This is my second attemp to make anyone notice the bug that is in the 
> 2.6.x tree. While many people tried to put blame on nvidia, here's a log 
> that shows that it's purely kernel fault not to work.
> 	At the end of this mail you can find some logs which show how 2.4.x and 
> 2.6.x kernels work with my card. I hope now someone can really  show 
> intrest into this, it's a shame something in 2.4.x worked (not perfect 
> but worked), and fails completely (system hang) in 2.6.x.
> 	It's also not nice if the system hangs (in 2.4.x) for a few seconds 
> while getting a preview (form the scanner), and gets jaggy and useless 
> while scanning, a userspace app (runned form normal user) shoudl not do 
> so, and it's not using more than 20% of CPU.

I don't think anyone has the actual hardware, without which it's quite
difficult to fix the problem.

What was the last 2.6 kernel version that this worked with?

James


