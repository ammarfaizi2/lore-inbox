Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbULUKSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbULUKSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbULUKSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:18:11 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10677 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261721AbULUKSG
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 21 Dec 2004 05:18:06 -0500
Subject: Re: [nptl] Re: OSDL Bug 3770
From: Sebastien Decugis <sebastien.decugis@ext.bull.net>
To: nptl@bullopensource.org
Cc: Loic Domaigne <loic-dev@gmx.net>, piggin@cyberone.com.au,
       Linux-Kernel@Vger.Kernel.ORG
In-Reply-To: <20041221100934.GA31538@elte.hu>
References: <9785.1103562168@www38.gmx.net> <20041221100934.GA31538@elte.hu>
Organization: Bull S.A.
Date: Tue, 21 Dec 2004 11:22:27 +0100
Message-Id: <1103624547.23533.137.camel@decugiss.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/12/2004 11:25:33,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/12/2004 11:25:34,
	Serialize complete at 21/12/2004 11:25:34
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> note that my -RT patchset includes scheduler changes that implement
> "global RT scheduling" on SMP systems. Give it a go, it's at:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> you have to enable CONFIG_PREEMPT_RT to active this feature. 

[...]
> 
> anyway, the first step would be to try this scheduler and give feedback
> of how well it works for you :-)

Thanks Ingo, this sounds very nice!

I'll try this hopefully before Christmas and give a status with this
patch applied.

Best regards,
Seb.

-- 
-------------------------------
Sebastien DECUGIS
NPTL Test & Trace Project
http://nptl.bullopensource.org/

"You may fail if you try.
You -will- fail if you don't."

