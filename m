Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVITSfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVITSfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVITSfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:35:13 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:63768 "EHLO
	BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP
	id S965061AbVITSfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:35:11 -0400
Message-ID: <BAYC1-PASMTP026836E1C3EF2589FFE007AE950@CEZ.ICE>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <59258.10.10.10.28.1127241246.squirrel@linux1>
In-Reply-To: <200509201759.j8KHxkbj000577@laptop11.inf.utfsm.cl>
References: Message from "Sean" <seanlkml@sympatico.ca>    of "Tue, 20 Sep
    2005 11:20:46 -0400." <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
    <56402.10.10.10.28.1127229646.squirrel@linux1>
    <200509201759.j8KHxkbj000577@laptop11.inf.utfsm.cl>
Date: Tue, 20 Sep 2005 14:34:06 -0400 (EDT)
Subject: Re: Arrr! Linux v2.6.14-rc2
From: "Sean" <seanlkml@sympatico.ca>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Sep 2005 18:33:41.0090 (UTC) FILETIME=[D2D62C20:01C5BE11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, September 20, 2005 1:59 pm, Horst von Brand said:

> Only that it doesn't work either today. Kernel stays at 2.6.14-rc1 as of
> yesterday (latest were a few NTFS patches), everything up to date.

Yeah, Russell pointed the same thing out a bit earlier.  There are 13
commits MIA.

> BTW, the cogito repository is hosed, cg-update can't get needed object
> 69ba00668be16e44cae699098694286f703ec61d. Fetching the contents by rsync
> gives the same mess.

For simply tracking the kernel there isn't much reason to use cogito. 
Using native git means fewer problems right now since both cogito and git
are developing quickly with inevitable version skew etc..

Sean

