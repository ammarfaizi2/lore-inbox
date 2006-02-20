Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWBTPrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWBTPrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWBTPrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:47:43 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:35461 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1030292AbWBTPrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:47:42 -0500
Date: Mon, 20 Feb 2006 16:47:37 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060220.153001.9382.albireo@ucw.cz>
References: <43EB7BBA.nailIFG412CGY@burner> <200602161742.26419.dhazelton@enter.net> <43F5B686.nail2VCA2A2OF@burner> <200602171502.20268.dhazelton@enter.net> <43F9D771.nail4AL36GWSG@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9D771.nail4AL36GWSG@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The SCSI glue layer on Solaris is less than 50 kB. I did mention more than once 
> that a uniquely layered system could save a lot of code by avoiding to 
> implement things more than once.

Could you please stop parrotting this again and again, at least as long as you
are unable to point to any duplicated code?

> Is Linux really that underdeveloped for not being able to provide DMA residual 
> counts?

How is it related to the discussion about interfaces?

So far, whenever you were asked to support your assertions (dynamic device
naming violating POSIX, duplicated code, your warning which is printed when
not using ide-scsi while the bugs you were speaking about occur only _with_
ide-scsi and so on), you have ignored the request and started either repeating
the same or diverting the attention to completely unrelated problems (like
above).

Unless you wish to stop spreading your demagogy and write facts instead,
I recommend you to shut up and this is my last mail in this discussion.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"This quote has been selected randomly. Really." -- M. Ulrichs
