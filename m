Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWJFKvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWJFKvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWJFKvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:51:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55427 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751450AbWJFKvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:51:50 -0400
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, discuss@x86-64.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610052344.18598.ak@suse.de>
References: <200610051910.25418.ak@suse.de> <200610051953.23510.ak@suse.de>
	 <1160085649.1607.35.camel@localhost.localdomain>
	 <200610052344.18598.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 12:14:20 +0100
Message-Id: <1160133260.1607.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 23:44 +0200, ysgrifennodd Andi Kleen:
> I think we had that argument before. IMHO such messages are completely
> useless. Hangs are not acceptable no matter what messages are printed
> before.

Oh so you plan to fix the iommu/aacraid problem you always said you
wouldn't fix ?
 
> > That gets us the best of both worlds.
> 
> Hanging systems? 

Working systems because the only hang case will be if you use hardware
that requires the new goodies on a box that is *actually* broken rather
than one which is misdetected by the paranoid check code. 

Alan

