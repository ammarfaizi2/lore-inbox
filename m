Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSGXQVn>; Wed, 24 Jul 2002 12:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSGXQVm>; Wed, 24 Jul 2002 12:21:42 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:42961 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S317385AbSGXQVm>; Wed, 24 Jul 2002 12:21:42 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Muli Ben-Yehuda <mulix@actcom.co.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot problem, 2.4.19-rc3-ac1
References: <Pine.LNX.4.44.0207241734320.17209-100000@linux-box.realnet.co.sz>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 24 Jul 2002 12:24:54 -0400
In-Reply-To: <Pine.LNX.4.44.0207241734320.17209-100000@linux-box.realnet.co.sz>
Message-ID: <9cf1y9t5c15.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> On 24 Jul 2002, Ian Soboroff wrote:
> 
> > Anyone have a clue on the IDE part of my question? ;-)
> 
> Oh.. yeah that, erm dunno. Hopefully someone with an idea will chime in 
> soon.
> 
> Cheers,
> 	Zwane
> 
> Or.. you can try find the last working -ac

I also had trouble with rc2-ac2.  I know Andre's been pushing IDE
changes through Alan, and from a quick scan through the rc3-ac1 patch
there's quite a bit of change in drivers/ide/alim15x3.c.

>From Alan's changelog, it looks like there were "ALi IDE hang fixes"
from Sen Dong in pre4-ac4 that were never pushed to Marcelo (according
to the changelog).



ian
