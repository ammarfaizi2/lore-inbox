Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTFEF6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 01:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTFEF6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 01:58:43 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:54725 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264488AbTFEF6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 01:58:42 -0400
Message-Id: <5.1.0.14.2.20030605080244.00af0a30@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 05 Jun 2003 08:12:05 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: PCI cache line messages 2.4/2.5
Cc: Jeff Garzik <jgarzik@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: S3Myh0ZcZeOQk7QxbVyBTZ8l4K-4P-0IpvARUA6wa-3IX+Nbe6Z-4N@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Jeff Garzik wrote :
 > Your BIOS did not set the PCI cache line size correctly.

Well, 2 questions :
2.4 gets 0 and sets 128. 2.5 gets 128 and reports it wrong.
This seems a contradiction. Which is right ?
Why only this port on the (onboard) USB hub ?

Margit

