Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264596AbUEVATy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbUEVATy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbUEVAEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:04:44 -0400
Received: from web40711.mail.yahoo.com ([66.218.78.168]:3774 "HELO
	web40711.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264664AbUEUXuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:50:20 -0400
Message-ID: <20040521143806.24507.qmail@web40711.mail.yahoo.com>
Date: Fri, 21 May 2004 07:38:06 -0700 (PDT)
From: l x <whereisit28@yahoo.com>
Subject: Help - how to include kernel header files (scsi_module.c) in a better way
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Suppose I need to include a kernel header file such
as:

"/usr/src/linux-2.4.20/drivers/scsi/scsi_module.c".

We also need to compile the driver in different lk2.4
environment so using "linux-2.4.20" in the path is not
a good idea.  How can I include it in src file so we
can compile it in different lk2.4 environment with
different kernel patches?

Thanks.

T.


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
