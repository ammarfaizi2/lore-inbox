Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965896AbWKHPbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965896AbWKHPbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965925AbWKHPbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:31:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23942 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965896AbWKHPbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:31:48 -0500
Subject: Re: [PATCH] drivers/scsi/mca_53c9x.c : save_flags()/cli() removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Amol Lad <amol@verismonetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1162945152.3625.2.camel@mulgrave.il.steeleye.com>
References: <1162816931.22062.132.camel@amol.verismonetworks.com>
	 <20061107125329.6dc4eb53.akpm@osdl.org>
	 <1162945152.3625.2.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 15:36:09 +0000
Message-Id: <1163000170.23956.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 09:19 +0900, ysgrifennodd James Bottomley:
> On Tue, 2006-11-07 at 12:53 -0800, Andrew Morton wrote:
> 
> > hm.  How do we find out if this works?
> 
> I'm not sure anyone has this type of HW anymore.  It was the original
> SCSI chip for the old MCA based IBM PC.  I can dig through my hardware
> bins to see if I have a card, but I don't think so.

There was one in the pile of MCA cards I posted you I think.


