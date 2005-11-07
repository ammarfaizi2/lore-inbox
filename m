Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVKGQhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVKGQhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVKGQhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:37:04 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:50443 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964869AbVKGQhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:37:03 -0500
Date: Mon, 7 Nov 2005 16:37:09 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
In-Reply-To: <436F7673.5040309@vmware.com>
Message-ID: <Pine.LNX.4.55.0511071632110.28165@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
 <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl>
 <436AA1FD.3010401@vmware.com> <p73fyqb2dtx.fsf@verdi.suse.de>
 <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl> <436F7673.5040309@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Zachary Amsden wrote:

> While this is at least no worse in the nested fault case than earlier 
> kernels, I really wish I had one of those weird 486s so I could test the 
> faulting mechanism.  It seems the trap handling code has gotten quite 

 What's so weird about 486s?  Besides, for testing it doesn't have to be
one -- you will get away with a 386, too.  I have neither anymore, but
there are people around still using them.

  Maciej
