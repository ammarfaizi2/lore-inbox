Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUJGNzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUJGNzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbUJGNzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:55:39 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:47957 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S266128AbUJGNzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:55:17 -0400
Message-ID: <56697.195.245.190.93.1097157219.squirrel@195.245.190.93>
Date: Thu, 7 Oct 2004 14:53:39 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, "Florian Schmidt" <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> 
      <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>   
    <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>   
    <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>   
    <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>   
    <20041007105230.GA17411@elte.hu>
In-Reply-To: <20041007105230.GA17411@elte.hu>
X-OriginalArrivalTime: 07 Oct 2004 13:55:12.0955 (UTC) FILETIME=[444218B0:01C4AC75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> please re-download it, this is another bug i've fixed in the re-uploaded
> version. Does the new patch work?
>

OK. Now it works fine. Thanks Ingo.

Maybe I'm just a plain idiot, but wouldn't it be welcome to add another
dot number or whatever to the VP filename label? IMHO that should clear
things of what actual patch release are we really applying.

The crash with jackd wasn't the only one, some other sound apps also failed
with similar kernel oopses dumps.

And, just out of curiosity, I've also tested "vanilla" 2.6.9-rc3-mm3 and
it looks like suffering from the same illness. So this has to be yet
another "feature" of the -mm line ;)

I'm glad this time VP came to the rescue :)

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


