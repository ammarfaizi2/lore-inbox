Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQKJInX>; Fri, 10 Nov 2000 03:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQKJInN>; Fri, 10 Nov 2000 03:43:13 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:15011 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129319AbQKJInJ>; Fri, 10 Nov 2000 03:43:09 -0500
From: Christoph Rohland <cr@sap.com>
To: mingo@elte.hu
Cc: Larry McVoy <lm@bitmover.com>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <Pine.LNX.4.21.0011091654030.2995-100000@elte.hu>
Organisation: SAP LinuxLab
Date: 10 Nov 2000 09:42:30 +0100
In-Reply-To: Ingo Molnar's message of "Thu, 9 Nov 2000 17:03:12 +0100 (CET)"
Message-ID: <qwwlmusjk09.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thu, 9 Nov 2000, Ingo Molnar wrote:
> 
> On Wed, 8 Nov 2000, Larry McVoy wrote:
> 
>> smart about that stuff, are least it seems so to me; he seems to be
>> well aware that 99.9999% of the hardware in the world isn't big
>> iron and never will be, so something approximating 99% of the
>> effort should be going towards the common platforms, not the
>> uncommon ones.
> 
> yep, this is true. Still Linux appears to perform remarkably well on
> so-called 'big iron'.

Thanks Ingo, I agree to this and also agree that we should try to be
able to run (mostly) everything from the same code base and I think
that's Linux does a great job on this.

Having a seperated code base for 0.0001% of mission critical servers
will lead to very bad availability or very high development cost at
least. In the worst (and not so unprobable) case it will lead to a lot
of games with licenses and 'intellectual property'. This would mean
that Linux fails to deliver on its promises IMHO.

Greetings
		Christoph
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
