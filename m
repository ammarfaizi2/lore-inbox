Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbUJ0HLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbUJ0HLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbUJ0HLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:11:22 -0400
Received: from holomorphy.com ([207.189.100.168]:45292 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262306AbUJ0HHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:07:00 -0400
Date: Tue, 26 Oct 2004 23:56:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Massimo Cetra <mcetra@navynet.it>
Cc: "'Willy Tarreau'" <willy@w.ods.org>, "'Rik van Riel'" <riel@redhat.com>,
       "'Marcos D. Marado Torres'" <marado@student.dei.uc.pt>,
       "'Ed Tomlinson'" <edt@aei.ca>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041027065625.GX15367@holomorphy.com>
References: <20041027062833.GV15367@holomorphy.com> <015b01c4bbf1$48069580$e60a0a0a@guendalin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015b01c4bbf1$48069580$e60a0a0a@guendalin>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was mercilessly stripped from:
> > 2.6.x has taken a rather different path from 2.4.x

On Wed, Oct 27, 2004 at 08:50:35AM +0200, Massimo Cetra wrote:
> However, results are similar. 
> 2.6 seems to work better than 2.4 in "early stage of stable branch" but
> It's quite impossible to set up a production server on 2.6.x, optimize
> it and keeping the same performance with 2.6.(x+2).

Bull. It's already been done, numerous times.


On Wed, Oct 27, 2004 at 08:50:35AM +0200, Massimo Cetra wrote:
> Iosched has a lot of flavours, with performance worse than 2.4 (at least
> for databases). 
> Swap is a misterious thing and It needs a degree in swappiness to
> understand how it works and how it changes.

Your complaint is a mysterious thing and needs a degree in mind-reading
to understand what you're trying to claim and how it's changed from the
last post.

In other words, rephrase this in some remotely scientific manner so
it's unambiguous and comprehensible.


On Wed, Oct 27, 2004 at 08:50:35AM +0200, Massimo Cetra wrote:
> I see a lot of efforts in making a top-performance kernel but these
> efforts are not compatible with a stable-tree.
> Stable means not only that the kernel does not hangs, but that features
> remains (almost) the same for a reasonable amount of time.

Backward compatibility remains a strict requirement as always, and
removals of features are still only allowed during major release cycles
e.g. between 2.4 and 2.6, after having given notice during 2.2.


-- wli
