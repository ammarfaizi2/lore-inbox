Return-Path: <linux-kernel-owner+w=401wt.eu-S1752903AbXACBTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbXACBTY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbXACBTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:19:24 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:56037 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbXACBTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:19:23 -0500
Date: Wed, 3 Jan 2007 02:13:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       devel@laptop.org, benh@kernel.crashing.org, wmb@firmworks.com,
       jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
In-Reply-To: <3676953abedcbe6d86da74a4997593cb@kernel.crashing.org>
Message-ID: <Pine.LNX.4.61.0701030213100.19644@yvahk01.tjqt.qr>
References: <459ABC7C.2030104@firmworks.com> <1167770882.6165.76.camel@localhost.localdomain>
 <978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
 <20070102.140749.104035927.davem@davemloft.net>
 <3676953abedcbe6d86da74a4997593cb@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 3 2007 01:52, Segher Boessenkool wrote:
>> > Leaving aside the issue of in-memory or not, I don't think
>> > it is realistic to think any completely common implementation
>> > will work for this -- it might for current SPARC+PowerPC+OLPC,
>> > but more stuff will be added over time...
>> 
>> I see nothing supporting this IMHO bogus claim.
>
> Please keep in mind that not all systems want to kill OF
> as soon as they enter the kernel -- some want to keep it
> active basically forever (or only remove it when the user
> asks for it).

Kill OF? sparc does not want that IMO, how else should I return to
the 'ok' prompt?


	-`J'
-- 
