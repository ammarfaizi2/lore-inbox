Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTKTA1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 19:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTKTA1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 19:27:24 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:30943 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264145AbTKTA1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 19:27:24 -0500
Date: Wed, 19 Nov 2003 19:25:19 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Losing too many ticks! TSC cannot be used as time source...
In-Reply-To: <1069281424.23578.27.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.GSO.4.33.0311191921080.13188-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 2003, john stultz wrote:
>> TSC became unusable. There are no other messages around this
>
>Hmmm. Interesting. You haven't seen it before and you've been running
>2.6.0-testX for awhile?

I see the same thing within vmware targets.  And the clock is either 2x
too fast or 2x too slow.  Go figure.  On real hardware, everything is
fine.

Usually, I ignore it. :-)

--Ricky

PS: I know... nobody cares that something is broken within vmware.


