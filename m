Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVJXQNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVJXQNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJXQNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:13:37 -0400
Received: from magic.adaptec.com ([216.52.22.17]:40924 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751127AbVJXQNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:13:36 -0400
Message-ID: <435D0828.4020307@adaptec.com>
Date: Mon, 24 Oct 2005 12:13:28 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Regala <matt@regala.cx>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Sergey Panov <sipan@sipan.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally	attached
 PHYs)
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com>	<435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com>	<43596070.3090902@pobox.com> <43596859.3020801@adaptec.com>	<43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>	<20051022105815.GB3027@infradead.org>	<1129994910.6286.21.camel@sipan.sipan.org>	<20051022171943.GA7546@infradead.org> <435CE6CA.4070704@adaptec.com>	<1130168495.12873.27.camel@localhost.localdomain>	<435CFA5A.2030104@adaptec.com> <87vezm7vox.fsf@barad-dur.minas-morgul.org>
In-Reply-To: <87vezm7vox.fsf@barad-dur.minas-morgul.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2005 16:13:33.0548 (UTC) FILETIME=[E19892C0:01C5D8B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/05 11:59, Regala wrote:
> but refactoring can be done in incremental pieces, can't be ?
> rewriting it from scratch is, in this very case, really for the sake
> of self-pride and brain-masturbation.
> Bravo
> 
> This is not a really convincing example...
> 
> -- 
> Mathieu Segaud

They, the factory, wanted it rewritten from scratch,
so that they can maintain and support it themselves.

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
