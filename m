Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbVITRJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVITRJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVITRJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:09:27 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:884 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932719AbVITRJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:09:26 -0400
Message-ID: <BAYC1-PASMTP04C95F4A2BA403E1EE1653AE950@cez.ice>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <52797.10.10.10.28.1127236164.squirrel@linux1>
In-Reply-To: <Pine.LNX.4.58.0509200959220.2553@g5.osdl.org>
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
    <BAYC1-PASMTP0390B5ABE91EDE56C81EDBAE950@cez.ice>
    <Pine.LNX.4.58.0509200959220.2553@g5.osdl.org>
Date: Tue, 20 Sep 2005 13:09:24 -0400 (EDT)
Subject: Re: Arrr! Linux v2.6.14-rc2
From: "Sean" <seanlkml@sympatico.ca>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Jan Dittmer" <jdittmer@ppp0.net>, "Alexander Nyberg" <alexn@telia.com>,
       "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Sep 2005 17:08:55.0663 (UTC) FILETIME=[FBAF97F0:01C5BE05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, September 20, 2005 1:02 pm, Linus Torvalds said:
> On Tue, 20 Sep 2005, Sean wrote:
>>
>> That's a good point.  Guess it would be useful if the HEAD commit was
>> documented along with each -gitX release.
>
> It is. Just get the "id" file that is associated with a snapshot, and it
> gives the git commit ID for that state.
>

Great!  Would there be anything standing in the way of having -gitX tags
automatically added to the git repository too?

Sean

