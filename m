Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSHIPSh>; Fri, 9 Aug 2002 11:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHIPSh>; Fri, 9 Aug 2002 11:18:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4001 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313743AbSHIPSg>;
	Fri, 9 Aug 2002 11:18:36 -0400
Date: Fri, 09 Aug 2002 08:19:53 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Paul Larson <plars@austin.ibm.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: daily 2.5 BK snapshots
Message-ID: <1505209847.1028881191@[10.10.2.3]>
In-Reply-To: <1028903778.19435.348.camel@plars.austin.ibm.com>
References: <1028903778.19435.348.camel@plars.austin.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I probably won't be using this since my scripts already do a nightly
> pull, but I'd also like to see what people think of this.  I have a
> setup that does a nightly pull of 2.5, builds it for UP and SMP, pushes
> to two machines (UP and SMP) and runs LTP on it.  Then sends me back the
> results of all of it.  Of course if something fails that didn't fail the
> previous day, I have a limited set of Changesets as culprits so it's
> easier for me to find the cause of problems when I do more frequent
> testing like this.  Any major problems are reported immediatly of
> course, but would anyone be interested in seeing the results of this
> more often?  I don't know if I have enough space on the LTP website to
> post all the data that's gathered every single day (It would add up
> REALLY fast), but would a weekly rollup to lkml be something people
> would like to see?

Personally, I'd love to see the *changes* in what passed and failed
posted every day - the whole result set is obviously too big. The 
quicker people know what's wrong, the quicker it gets fixed, before
we build more on top of an unstable foundation.

M.

