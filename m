Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUEAGKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUEAGKb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 02:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUEAGKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 02:10:31 -0400
Received: from sev.net.ua ([212.86.233.226]:35853 "EHLO sev.net.ua")
	by vger.kernel.org with ESMTP id S261787AbUEAGK3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 02:10:29 -0400
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
From: Alex Lyashkov <shadow@psoft.net>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040430234332.GA10569@MAIL.13thfloor.at>
References: <20040430174117.A13372@infradead.org>
	 <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com>
	 <4092AD60.1030809@watson.ibm.com>
	 <200404302217.i3UMHdml004610@ccure.user-mode-linux.org>
	 <20040430234332.GA10569@MAIL.13thfloor.at>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Organization: PSoft
Message-Id: <1083391814.8172.8.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sat, 01 May 2004 09:10:15 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

÷ óÂÔ, 01.05.2004, × 02:43, Herbert Poetzl ÐÉÛÅÔ:
> On Fri, Apr 30, 2004 at 06:17:39PM -0400, Jeff Dike wrote:
> > nagar@watson.ibm.com said:
> > > Jeff, do you have any numbers for UML overhead in 2.6 ? 
> > 
> > It obviously depends on the workload, but for "normal" things, like kernel
> > builds and web serving, it's generally in the 20-30% range.  That can be 
> > reduced, since I haven't spent too much time on tuning.  I'm aiming for the
> > teens, and I don't think that'll be too hard.
> 
> hmm, just wanted to mention that linux-vserver has
> around 0% overhead and often allows to improve 
> performance due to resource sharing ... 
> 
Herber please not say vserver have - 0 overhead. 
it generally wrong.
But overhead less than UML is right.


> basically it's a soft partitioning concept based on 
> 'Security Contexts' which allow to create many 
> independant Virtual Private Servers (VPS), which
> act simultaneously on one box at full speed, sharing
> the available hardware resources.
> 
> see http://linux-vserver.org for details ...
> 
> best,
> Herbert
> 
> PS: UML and Linux-VServer play together nicely ...
> 
> > 
> > 				Jeff
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: Oracle 10g
> > Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> > Take an Oracle 10g class now, and we'll give you the exam FREE. 
> > http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> > _______________________________________________
> > ckrm-tech mailing list
> > https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Alex Lyashkov <shadow@psoft.net>
PSoft
