Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945902AbWBCTSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945902AbWBCTSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945900AbWBCTSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:18:10 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:17176 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1945902AbWBCTSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:18:09 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'Brian D. McGrew'" <brian@visionpro.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Stale NFS File Handle
Date: Fri, 3 Feb 2006 13:28:41 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1138993744.7861.18.camel@lade.trondhjem.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYo9MZCyVHAILDZSFi6pPdQ/5SxqgAAySWg
Message-ID: <EXCHG20033Bma4RCIlW000011fb@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 03 Feb 2006 19:11:26.0481 (UTC) FILETIME=[A14B6810:01C628F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> 
> Kernels prior to 2.6.12 (if memory serves me correctly) had a 
> series of errors in the code that converts filehandles into 
> valid dentries on the server. Upgrading to the FC4 kernel, 
> which I believe to be 2.6.14 based, is therefore very likely 
> to solve your problem.
> 
> Cheers,
>   Trond

Default FC4 is 2.6.11... so he would need to install on of the
updated kernels on FC4.

                           Roger

