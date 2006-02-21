Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWBUScI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWBUScI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWBUScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:32:08 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:21683 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932337AbWBUScF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:32:05 -0500
Message-ID: <43FB5C5D.8040907@cfl.rr.com>
Date: Tue, 21 Feb 2006 13:30:53 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <200602131116.41964.david-b@pacbell.net> <200602192150.05567.david-b@pacbell.net> <43F9E95A.6080103@cfl.rr.com> <200602210819.57740.david-b@pacbell.net>
In-Reply-To: <200602210819.57740.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2006 18:33:26.0185 (UTC) FILETIME=[4D915990:01C63715]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14281.000
X-TM-AS-Result: No--11.450000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Monday 20 February 2006 8:07 am, Phillip Susi wrote:
>> And this is exactly how non USB hardware has behaved for eons, and it 
>> hasn't been a problem. 
> 
> How many billions of years exactly?  :)
> 

<G>

> Of course it sometimes _has_ been a problem.  Repeating your claim
> doesn't make it true.  And the user model of USB was certainly so
> those problems could be _prevented_ rather than continued forever
> into new generations of hardware.
> 

But it hasn't been prevented, just changed into a less destructive, but 
more prevelant problem.  If you want to try to solve the problem then it 
should be solved in such a way that it does not cause other problems ( 
breaking mounts when you suspend ) and the solution should be 
generalized to all disks rather than just USB.

> The fact that MS-DOS did something does not make it a good idea.
> 
> 
> This is LKML.  Pointing out when patches are overdue
> can't realistically be taken as a flame; it's a
> standard way of moving beyond discussion to action.
> (Or helping someone self-educate about issues they
> won't see until they, too, look more deeply ...)
> 

I think you got the thread confused.  The flame was:

 >>> changing all that stuff, he also needs stop being a
 >>> member of the "never submitted a USB patch" club.

> However, responding to a "request for patch" in that
> way certainly does come across as a flame.

