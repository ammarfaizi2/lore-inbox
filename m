Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRDWE3S>; Mon, 23 Apr 2001 00:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDWE3J>; Mon, 23 Apr 2001 00:29:09 -0400
Received: from ferret.phonewave.net ([208.138.51.183]:62479 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130466AbRDWE24>; Mon, 23 Apr 2001 00:28:56 -0400
Date: Sun, 22 Apr 2001 21:28:27 -0700
To: Manuel McLure <manuel@mclure.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hang on multi-threaded X process crash
Message-ID: <20010422212827.A23096@ferret.phonewave.net>
In-Reply-To: <20010422185514.A981@ulthar.internal.mclure.org> <20010422192704.C3618@ulthar.internal.mclure.org> <20010422201701.A970@ulthar.internal.mclure.org> <20010422202339.G970@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010422202339.G970@ulthar.internal.mclure.org>; from manuel@mclure.org on Sun, Apr 22, 2001 at 08:23:39PM -0700
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 08:23:39PM -0700, Manuel McLure wrote:
> 
> On 2001.04.22 20:17 Manuel McLure wrote:
> > 
> > To follow up on my followup, I can now reproduce this 100% and get the
> > "Trying to vfree()..." message on the console. To do this I start
> > Mozilla,
> > switch to a text console, and do a "killall -QUIT mozilla". A couple of
> 
> Make that "killall -QUIT mozilla-bin"...

I'll see if mine does this too. I've been having hard locks
intermittantly too, sometimes starting X, mostly with mozilla. My
system's a dual Pmmx200 with ATI rage pro and Matrox Mill 2 PCI.

-- Ferret
