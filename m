Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288593AbSANBdK>; Sun, 13 Jan 2002 20:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288595AbSANBdB>; Sun, 13 Jan 2002 20:33:01 -0500
Received: from holomorphy.com ([216.36.33.161]:55192 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288594AbSANBck>;
	Sun, 13 Jan 2002 20:32:40 -0500
Date: Sun, 13 Jan 2002 17:32:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] update: preemptive kernel for O(1) sched
Message-ID: <20020113173222.D934@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200201132325.g0DNPrm05503@zero.tech9.net> <1010965697.813.25.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1010965697.813.25.camel@phantasy>; from rml@tech9.net on Sun, Jan 13, 2002 at 06:48:17PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 18:22, Dieter N?tzel wrote:
>> what about lock-break?
>> I am running your former one as always with 
>> lock-break-rml-2.4.18-pre1-1.patch ...;-)

On Sun, Jan 13, 2002 at 06:48:17PM -0500, Robert Love wrote:
> I haven't tested O(1) together with lock-break personally, yet, but I
> have a confirmation of success from a couple of users.  There are no
> reasons it shouldn't work.

I have at least run it on my laptop, together with rmap even.
No pathological behavior that I can tell. Of course, the interactive
response is wonderful, but I haven't precisely measured anything, as
I have enough other things to measure precisely it's a bit far afield.


Cheers,
Bill
