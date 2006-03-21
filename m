Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWCUJOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWCUJOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWCUJOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:14:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35083 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751352AbWCUJON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:14:13 -0500
Date: Tue, 21 Mar 2006 10:13:53 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: interactive task starvation
Message-ID: <20060321091353.GA25248@w.ods.org>
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org> <cone.1141774323.5234.18683.501@kolivas.org> <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu> <1142592375.7895.43.camel@homer> <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer> <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142927498.7667.34.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Mar 21, 2006 at 08:51:38AM +0100, Mike Galbraith wrote:
> On Tue, 2006-03-21 at 07:47 +0100, Willy Tarreau wrote:
> > Hi Mike,
> 
> Greetings!

Thanks for the details,
I'll try to find some time to test your code quickly. If this fixes this
long standing problem, we should definitely try to get it into 2.6.17 !

Cheers,
Willy

