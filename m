Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTJPRtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTJPRtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:49:07 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:46344 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263102AbTJPRs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:48:57 -0400
Date: Thu, 16 Oct 2003 18:48:50 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
In-Reply-To: <20031016104445.GW17986@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0310161848180.7130-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> > Several fixes. The patch is against 2.6.0-test7
> > 
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> >...
> 
> When reaming entries in pci_ids.h you should check whether there are 
> other users.
> 
> The following compile error was caused by your patch:

Ug. I turned on all the DRI and APG drivers and well as the fbdev drivers. 
Will fix.


