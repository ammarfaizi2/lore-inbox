Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291296AbSBGUxo>; Thu, 7 Feb 2002 15:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291298AbSBGUxZ>; Thu, 7 Feb 2002 15:53:25 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:50577 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291296AbSBGUxJ>;
	Thu, 7 Feb 2002 15:53:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>
Subject: Re: [RFC] New locking primitive for 2.5
Date: Thu, 7 Feb 2002 21:57:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@transmet.com,
        mingo@elte.hu, nigel@nrg.org
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013113285.11659.84.camel@phantasy> <20020207133602.C21935@hq.fsmlabs.com>
In-Reply-To: <20020207133602.C21935@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Yvbr-00015i-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 09:36 pm, yodaiken@fsmlabs.com wrote:
> > P.S. If this is going to turn into another priority-inheritance flame, I
> > am stopping here.  Let's take it off-list or just drop it, please.  I'd
> > much prefer to discuss the current combilock issue which is at hand. ;)
> 
> It's the same issue.

Not necessarily, look at Ingo's observation about replacing semaphores with 
combi-locks as opposed to replacing spinlocks with combi-locks.

-- 
Daniel
