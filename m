Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVCIS2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVCIS2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCIS2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:28:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43402 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262179AbVCISZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:25:18 -0500
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503090908260.2530@ppc970.osdl.org>
References: <200503081937.j28Jb4Vd020597@hera.kernel.org>
	 <1110387326.28860.199.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0503090908260.2530@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110392606.28860.220.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 18:23:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 17:09, Linus Torvalds wrote:
> On Wed, 9 Mar 2005, Alan Cox wrote:
> > 
> > This patch was discussed previously and declared incorrect.
> 
> Well, it was also declared as a "don't care" by Dave, I think, by virtue 
> of nobody having ever complained.

And in further discussion people produced the relevant CPU's. Its a
performance hit (30% on winchip). 

Alan

