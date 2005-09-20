Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVITQuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVITQuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVITQuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:50:50 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:31694 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932669AbVITQut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:50:49 -0400
Message-ID: <BAYC1-PASMTP0390B5ABE91EDE56C81EDBAE950@cez.ice>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <48312.10.10.10.28.1127235046.squirrel@linux1>
In-Reply-To: <43303C85.1020301@ppp0.net>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>      
    <200509201005.49294.gene.heskett@verizon.net>      
    <20050920141008.GA493@flint.arm.linux.org.uk>      
    <200509201025.36998.gene.heskett@verizon.net>      
    <56402.10.10.10.28.1127229646.squirrel@linux1>      
    <20050920153231.GA2958@localhost.localdomain>   
    <BAYC1-PASMTP030BBDF3F9B2552DA9CF26AE950@cez.ice>   
    <43303650.5030202@sfhq.hn.org>
    <BAYC1-PASMTP033EBAB483DBE4397549B2AE950@cez.ice>
    <43303C85.1020301@ppp0.net>
Date: Tue, 20 Sep 2005 12:50:46 -0400 (EDT)
Subject: Re: Arrr! Linux v2.6.14-rc2
From: "Sean" <seanlkml@sympatico.ca>
To: "Jan Dittmer" <jdittmer@ppp0.net>
Cc: "Alexander Nyberg" <alexn@telia.com>,
       "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Sep 2005 16:50:21.0106 (UTC) FILETIME=[635BB120:01C5BE03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, September 20, 2005 12:44 pm, Jan Dittmer said:

> I know, but for multiple people testing daily releases it's much easier to
> say -git1 worked -git2 didn't. Sure, for searching the patch `git bisect`
> is priceless but for regular testing the -gitx thing comes very handy.
> Otherwise you can get a arbitrary intermediate state of linus tree if
> you're pulling at the wrong moment. It's actually also faster I suppose
> to get one patch than running `git pull` - at least with a cold cache
> (it used to be in the 0.1 days of git).
> Just my .02,

That's a good point.  Guess it would be useful if the HEAD commit was
documented along with each -gitX release.

Sean

