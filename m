Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284283AbRLXA0Y>; Sun, 23 Dec 2001 19:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284282AbRLXA0Q>; Sun, 23 Dec 2001 19:26:16 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:37393 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S284272AbRLXA0G>;
	Sun, 23 Dec 2001 19:26:06 -0500
Date: Sun, 23 Dec 2001 17:19:15 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: george anzinger <george@mvista.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011223171915.B19931@hq2>
In-Reply-To: <3C22654D.7FC80713@mvista.com> <Pine.LNX.4.40.0112201432120.1622-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112201432120.1622-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:36:07PM -0800, Davide Libenzi wrote:
> > My understanding of the POSIX standard is the the highest priority
> > task(s) are to get the cpu(s) using the standard calls.  If you want to
> > deviate from this I think the standard allows extensions, but they IMHO
> > should be requested, not the default, so I would turn your flag around
> > to force LOCAL, not GLOBAL.
> 
> So, you're basically saying that for a better standard compliancy it's
> better to have global preemption policy by default. And having users to
> request rt tasks localization explicitly. It's fine for me.

Can you please cite the passaaages in the standrd you have in mind?

> 
> 
> 
> 
> - Davide
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
