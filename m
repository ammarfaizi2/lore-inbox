Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273797AbRIRBYs>; Mon, 17 Sep 2001 21:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273798AbRIRBYh>; Mon, 17 Sep 2001 21:24:37 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:46297 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S273797AbRIRBYY>;
	Mon, 17 Sep 2001 21:24:24 -0400
Date: Tue, 18 Sep 2001 03:24:44 +0200
From: David Weinehall <tao@acc.umu.se>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens)
Message-ID: <20010918032444.M26627@khan.acc.umu.se>
In-Reply-To: <20010918001826.7D118A0E5@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010918001826.7D118A0E5@oscar.casa.dyndns.org>; from tomlins@cam.org on Mon, Sep 17, 2001 at 08:18:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 08:18:25PM -0400, Ed Tomlinson wrote:
> Hi,
> 
> Seems like there is a lot of code "ready" for consideration in a 2.5 kernel.
> I can think of:
> 
> premptable kernel option
> user mode kernel 
> jfs
> xfs (maybe)

ext3

> rc2
> reverse maping vm
> ide driver rewrite
> 32bit dma
> LTT (maybe)
> LVM update to 1.01
> ELVM (maybe)

I guess you mean EVMS?

> module security stuff
> UP friendly SMP scheduler
> 
> What else?

CML2
KBuild v2.5
^^^
These two are my prio #1.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
