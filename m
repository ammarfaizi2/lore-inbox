Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269660AbUJGOOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbUJGOOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269664AbUJGOOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:14:54 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:40667 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269660AbUJGOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:14:28 -0400
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <56697.195.245.190.93.1097157219.squirrel@195.245.190.93>
Message-ID: <cone.1097158438.547217.10282.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       =?ISO-8859-1?B?Sy5SLg==?= Foley <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>, mark_h_johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: voluntary-preempt-2.6.9-rc3-mm3-T3
Date: Fri, 08 Oct 2004 00:13:58 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela writes:

>>
>> please re-download it, this is another bug i've fixed in the re-uploaded
>> version. Does the new patch work?
>>
> 
> OK. Now it works fine. Thanks Ingo.
> 
> Maybe I'm just a plain idiot, but wouldn't it be welcome to add another
> dot number or whatever to the VP filename label? IMHO that should clear
> things of what actual patch release are we really applying.
> 
> The crash with jackd wasn't the only one, some other sound apps also failed
> with similar kernel oopses dumps.
> 
> And, just out of curiosity, I've also tested "vanilla" 2.6.9-rc3-mm3 and
> it looks like suffering from the same illness. So this has to be yet
> another "feature" of the -mm line ;)

Known issue;

Follow this advice:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109714329614794&w=2

Con

