Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310452AbSCBVAN>; Sat, 2 Mar 2002 16:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310453AbSCBVAD>; Sat, 2 Mar 2002 16:00:03 -0500
Received: from zero.tech9.net ([209.61.188.187]:13070 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S310452AbSCBU74>;
	Sat, 2 Mar 2002 15:59:56 -0500
Subject: Re: 2.4.19pre1aa1
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <20020302214739.B20606@dualathlon.random>
In-Reply-To: <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com>
	<200203021958.g22JwKq08818@Port.imtp.ilyichevsk.odessa.ua> 
	<20020302214739.B20606@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 02 Mar 2002 15:58:21 -0500
Message-Id: <1015102702.14000.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-02 at 15:47, Andrea Arcangeli wrote:

> On Sat, Mar 02, 2002 at 09:57:49PM -0200, Denis Vlasenko wrote:
>
> > If rmap is really better than current VM, it will be merged into head 
> > development branch (2.5). There is no anti-rmap conspiracy :-)
> 
> Indeed.

Of note: I don't think anyone "loses" if one VM is merged or not.  A
reverse mapping VM is a significant redesign of our current VM approach
and if it proves better, yes, I suspect (and hope) it will be merged
into 2.5.

But that doesn't mean the 2.4 VM is worse, per se.

	Robert Love

