Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWAWNp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWAWNp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWAWNp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:45:26 -0500
Received: from darwin.snarc.org ([81.56.210.228]:25264 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1751395AbWAWNp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:45:26 -0500
Date: Mon, 23 Jan 2006 14:45:24 +0100
To: Johan Kullstam <kullstj-ml@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060123134523.GA31752@snarc.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <1137785271.13530.10.camel@grayson> <20060120220440.GA22061@snarc.org> <8764odbfjb.fsf@sophia.axel.nom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8764odbfjb.fsf@sophia.axel.nom>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 01:29:44PM -0500, Johan Kullstam wrote:
> Why not just drop the "2"?  It's not like the "2" is going anywhere
> with current or even with the past development models.  2.X.Y has
> already been used (for X = 0-6 and modest Y), so 6.16.1 could be used
> instead of 2.6.16-rc1.

Just want to make clear, I wasn't taking about reusing 2.0, 2.1 ..
but just continue from 2.6 as the following example:
   
   2.6.16   => 2.7.0
   2.6.16.1 => 2.7.1
   2.6.16.2 => 2.7.2
   2.6.17   => 2.8.0
   2.6.18   => 2.9.0
   ...

The development model stays exactly the same:
i.e. 2.X.0 kernels are released every ~N weeks by Linus.

-- 
Vincent Hanquez
