Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUHKRYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUHKRYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUHKRVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:21:41 -0400
Received: from main.gmane.org ([80.91.224.249]:65235 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268131AbUHKRUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:20:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: OT: Distribution for Power4 Machines
Date: Wed, 11 Aug 2004 10:20:38 -0700
Message-ID: <pan.2004.08.11.17.20.38.570218@triplehelix.org>
References: <20040811055622.52917.qmail@web13911.mail.yahoo.com> <15070000.1092237689@[10.10.2.4]> <1092238482.6033.4.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 64-60-248-66.cust.telepacific.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 08:34:42 -0700, Dave Hansen wrote:

> On Wed, 2004-08-11 at 08:21, Martin J. Bligh wrote:
>> >  sorry for the most likely off-topic post. Are there any distributions
>> > out there that support IBM Power4 systems (pSeries machines)?
>> 
>> RH, SuSE and Debian all do, though maybe only the expensive enterprise
>> versions of the former 2.
> 
> You can install Debian, it's just a bit of a pain.  You basically have
> to replace the installer kernel with your own, and use the debian
> root.bin floppy as your kernel initrd.  

Um. Dude. That's old.

Thanks to Sven Luther our new installer fully supports power4 (as far as
I know, I don't personally own one.)

http://gluck.debian.org/cdimage/testing/daily/powerpc/current/

should contain a CD image that can boot your machine.

-- 
Joshua Kwan


