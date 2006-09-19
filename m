Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWISRKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWISRKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWISRKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:10:19 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:14087 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1030329AbWISRKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:10:17 -0400
Date: Tue, 19 Sep 2006 18:10:17 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Amy Fong <amy.fong@windriver.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Add Broadcom PHY support
In-Reply-To: <45101EC1.7040407@garzik.org>
Message-ID: <Pine.LNX.4.64N.0609191808470.24069@blysk.ds.pg.gda.pl>
References: <E1GPflG-0000n7-2o@lucciola> <Pine.LNX.4.64N.0609191441260.24069@blysk.ds.pg.gda.pl>
 <45101EC1.7040407@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Jeff Garzik wrote:

> >  And sb1250-mac.c would be happy to use it too.
> 
> "would be happy to" != "is using".   I don't want to add a phy driver until
> there are already active users in the kernel.

 Fair enough, but Amy may be looking forward to seeing yet another piece 
of code using the new driver. ;-)

  Maciej
