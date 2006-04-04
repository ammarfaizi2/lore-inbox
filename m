Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWDDKw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWDDKw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 06:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWDDKw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 06:52:57 -0400
Received: from vmailb.mclink.it ([195.110.128.107]:11016 "EHLO
	vmailb.mclink.it") by vger.kernel.org with ESMTP id S1751850AbWDDKw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 06:52:56 -0400
From: "Mauro Tassinari" <mtassinari@cmanet.it>
To: "'Jeff Garzik'" <jeff@garzik.org>
Cc: "'Tejun Heo'" <htejun@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: R: libata/sata status on ich[?]
Date: Tue, 4 Apr 2006 12:52:36 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAjHV4O85/nUSHCErZCEm5IwEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <443241F4.7080801@garzik.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Da: Jeff Garzik 
> 
> Tejun Heo wrote:
> > This should be fixed by the ata_piix map patch I've submitted and is
> > currently in #upstream. [ P0 P1 P2 P3 ] should be [ P0 P2 P1 P3 ].
> 
> If you are referring to this fix:
> 
> > commit 79ea24e72e59b5f0951483cc4f357afe9bf7ff89
> > Author: Tejun Heo <htejun@gmail.com>
> > Date:   Fri Mar 31 20:01:50 2006 +0900
> > 
> >     [PATCH] ata_piix: fix ich6/m_map_db
> 
> then its already in linux-2.6.git, and 2.6.17-rc1.
> 
> 	Jeff
> 

Confirm. Works correctly with both linux-2.6.16.1 and 2.6.17-rc1.

Thanks

Best regards

Mauro Tassinari

