Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269909AbUJGXcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269909AbUJGXcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJGX31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:29:27 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:28856 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269926AbUJGX2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:28:39 -0400
Message-ID: <32798.192.168.1.5.1097191570.squirrel@192.168.1.5>
Date: Fri, 8 Oct 2004 00:26:10 +0100 (WEST)
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
             <20040923211206.GA2366@elte.hu>
    <20040924074416.GA17924@elte.hu>         
    <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>        
     <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>     
        <20041007105230.GA17411@elte.hu>   
    <56697.195.245.190.93.1097157219.squirrel@195.245.190.93>
In-Reply-To: <56697.195.245.190.93.1097157219.squirrel@195.245.190.93>
X-OriginalArrivalTime: 07 Oct 2004 23:28:35.0634 (UTC) FILETIME=[5DDA5120:01C4ACC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>>
>> i've released the -T3 VP patch:
>>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
>>
>

OK. Just to let you know, both of my personal machines are now running on
bleeding-edge 2.6.9-rc3-mm3-T3, and very happily may I assure :)

- my laptop, Mandrake 10.1c: P4@2.5GHz UP
- my desktop, SUSE 9.1 Pro: P4@2.8GHz HT/SMP

USB is fine and so is jackd, only to mention my recently known annoyances.

Even my Wacom Graphire USB is working without anything else but the kernel
supplied stuff. Most of the previous kernel installs I had to pullover
from linuxwacom.sf.net the mousedev, evdev and wacom modules, just to get
this tablet working straight on X, but now it seems pretty native :)

Good times are we living, eh?

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


