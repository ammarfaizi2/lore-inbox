Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbSIWTcI>; Mon, 23 Sep 2002 15:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSIWTat>; Mon, 23 Sep 2002 15:30:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261329AbSIWSlh>;
	Mon, 23 Sep 2002 14:41:37 -0400
Date: Mon, 23 Sep 2002 11:34:52 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Message-ID: <20020923163452.GF9726@waste.org>
References: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com> <1032791089.3d8f2431231ac@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032791089.3d8f2431231ac@kolivas.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 12:24:49AM +1000, Con Kolivas wrote:
> 
> That is the system I was considering. I just need to run enough
> benchmarks to make this worthwhile though. That means about 5 for
> each it seems - which may take me a while. A basic mean will suffice
> for a measure of central tendency. I also need to quote some measure
> of variability. Standard deviation?

No, standard deviation is inappropriate here. We have no reason to
expect the distribution of problem cases to be normal or even smooth.
What we'd really like is range and mean. Don't throw out the outliers
either, the pathological cases are of critical interest.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
