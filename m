Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVLNSno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVLNSno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVLNSno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:43:44 -0500
Received: from math.ut.ee ([193.40.36.2]:58564 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S964871AbVLNSnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:43:43 -0500
Date: Wed, 14 Dec 2005 20:43:27 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
In-Reply-To: <20051214172445.GF7124@flint.arm.linux.org.uk>
Message-ID: <Pine.SOC.4.61.0512142042570.16591@math.ut.ee>
References: <1134573803.25663.35.camel@localhost.localdomain>
 <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, possibly, but could you apply this patch and provide the resulting
> messages please?  It'll probably cause some character loss when it
> decides to dump some debugging.

Not before friday unfortunately, but I will try then.

-- 
Meelis Roos (mroos@linux.ee)
