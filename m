Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272556AbTGaRUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272564AbTGaRUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:20:49 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:55730 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S272556AbTGaRUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:20:48 -0400
Date: Thu, 31 Jul 2003 10:20:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ihar Philips Filipau <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
Message-ID: <20030731172046.GH27214@ip68-0-152-218.tc.ph.cox.net>
References: <eLVb.3yF.1@gated-at.bofh.it> <eOJn.5NI.1@gated-at.bofh.it> <f1dJ.GS.21@gated-at.bofh.it> <faTE.2LQ.3@gated-at.bofh.it> <fd56.4Te.9@gated-at.bofh.it> <fdRv.5uB.9@gated-at.bofh.it> <fnHd.54o.19@gated-at.bofh.it> <3F294461.2020902@softhome.net> <20030731164326.GG27214@ip68-0-152-218.tc.ph.cox.net> <3F294C31.6030702@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F294C31.6030702@softhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 07:04:49PM +0200, Ihar Philips Filipau wrote:
> Tom Rini wrote:
> >
> >Shutdown != sleep.  If you want to wake devices up again, you need to do
> >them in the right order.
> 
>     You didn't get my point.
>     My appliances do not need sleep/shutdown at all.
>     Not every embedded system is a handheld ;-)

That certainly is true, yes.  They might want to power things down when
the user isn't there (or maybe they don't, I don't know what you're
making :)).  And I did originally say 'some'.

-- 
Tom Rini
http://gate.crashing.org/~trini/
