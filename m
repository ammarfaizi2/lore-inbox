Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131722AbRCXRSU>; Sat, 24 Mar 2001 12:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131723AbRCXRSK>; Sat, 24 Mar 2001 12:18:10 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:10493
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S131722AbRCXRR7>; Sat, 24 Mar 2001 12:17:59 -0500
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Doug McNaught <doug@wireboard.com>, Gerhard Mack <gmack@innerfire.net>
Subject: Re: [OT] Linux Worm (fwd)
Date: Sat, 24 Mar 2001 11:11:50 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Bob Lorenzini <hwm@newportharbornet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10103231028250.9403-100000@innerfire.net> <m3ae6c48v4.fsf@belphigor.mcnaught.org>
In-Reply-To: <m3ae6c48v4.fsf@belphigor.mcnaught.org>
MIME-Version: 1.0
Message-Id: <01032411170201.03927@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Doug McNaught wrote:
>Gerhard Mack <gmack@innerfire.net> writes:
>
>> On Fri, 23 Mar 2001, Bob Lorenzini wrote:
>> 
>> > I'm annoyed when persons post virus alerts to unrelated lists but this
>> > is a serious threat. If your offended flame away.
>> 
>> This should be a wake up call... distributions need to stop using product
>> with consistently bad security records. 
>
>Is there an alternative to BIND that's free software?  Never seen
>one. 

Not one that is Open Source....

Bind itself has been proven over many years. This is the first major
problem found. If you want a fix, get bind v9. Besides handling IP version
4, it also handles version 6.

The only current limitation is the inability to control sort order of
hosts with multiple interfaces. I think this is due to the new IP v 6
resource handling.

Bind 9 works well (see ISC web page http://www.isc.org/products/BIND/)

>
>-Doug (who doesn't think this is a Good Thing)

It really isn't, but the new bind may be. There is even an update
to bind 8 that contains a fix for the problem.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
