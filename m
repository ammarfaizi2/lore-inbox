Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288977AbSAITjX>; Wed, 9 Jan 2002 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288976AbSAITjN>; Wed, 9 Jan 2002 14:39:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:55544 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288978AbSAITjA>;
	Wed, 9 Jan 2002 14:39:00 -0500
Date: Wed, 9 Jan 2002 11:38:33 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020109113833.J1149@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.40.0201090940490.1595-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.33.0201092218450.7442-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201092218450.7442-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jan 09, 2002 at 10:24:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 10:24:00PM +0100, Ingo Molnar wrote:
>                                                (if you are about to run
> comparisons, i'd suggest the -G1 patch so you'll have all the recent
> fixes.)

I just kicked off another benchmark run to compare pre10, pre10 & G1
patch, pre10 & Davide's patch.  chat and make will be run as before
with the addition of chat reniced.  I won't attempt to make any claims
about interactive responsiveness.  Simple throughput numbers.  Results
should be available in about 24 hours.

-- 
Mike
