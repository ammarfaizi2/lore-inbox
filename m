Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNOcT>; Wed, 14 Feb 2001 09:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBNOb6>; Wed, 14 Feb 2001 09:31:58 -0500
Received: from expanse.dds.nl ([194.109.10.118]:48903 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S129051AbRBNObr>;
	Wed, 14 Feb 2001 09:31:47 -0500
Date: Wed, 14 Feb 2001 15:31:19 +0100
From: Ookhoi <ookhoi@dds.nl>
To: Daniel Quinlan <quinlan@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setting cpu speed on crusoe
Message-ID: <20010214153119.K30236@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010210224855.D7877@bug.ucw.cz> <Pine.LNX.4.10.10102130928490.29787-100000@penguin.transmeta.com> <6y66idbiai.fsf@magnesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
In-Reply-To: <6y66idbiai.fsf@magnesium.transmeta.com>; from quinlan@transmeta.com on Wed, Feb 14, 2001 at 03:44:37AM -0800
X-Uptime: 12:48pm  up 15 days, 23:52, 21 users,  load average: 0.12, 0.08, 0.30
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> > We're going through our docs and we have internal programs that
> > we'll release for this so that you'll not just have docs but
> > actually working code too. It just needs to be cleaned up a bit, and
> > go through the proper channels (ever wonder why open source gets
> > deveoped faster?). It really should be "any day now".
> 
> Working code is better anyway (and in this case, it's first).  Go to
> your favorite kernel.org mirror and check out
> 
>   /pub/linux/utils/cpu/crusoe/longrun-0.9.tar.gz
> 
> It does everything you could ever want and more, as long as you
> include the CPUID and MSR devices in your kernel, set up the devices
> correctly, etc.

Very cool. :-)  Will we also be able to do a software upgrade of the cpu
code morphing software in the future?

	Ookhoi
