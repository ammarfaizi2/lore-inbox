Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263531AbTC3KFr>; Sun, 30 Mar 2003 05:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263532AbTC3KFr>; Sun, 30 Mar 2003 05:05:47 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:21894 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263531AbTC3KFq>; Sun, 30 Mar 2003 05:05:46 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Robert Love <rml@tech9.net>
Cc: Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1048989922.13757.20.camel@localhost>
References: <3E8610EA.8080309@telia.com>
	 <1048980204.13757.17.camel@localhost>  <1048987260.679.7.camel@teapot>
	 <1048989922.13757.20.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1049019383.597.0.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 30 Mar 2003 12:16:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-30 at 04:05, Robert Love wrote:
> I was wondering, since we are working on an actual bug here, whether or
> not renicing X is leading to a starvation issue between X and whatever
> is starving.  I have seen it before.
> 
> My system is responsive, too, and I do not renice X.  But it might
> help.  Or it might cause starvation issues.  We have a bug somewhere...

I'm gonna try renicing X to see how it behaves...

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

