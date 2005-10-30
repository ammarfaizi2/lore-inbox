Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbVJ3BMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbVJ3BMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbVJ3BMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:12:20 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:43384 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932760AbVJ3BMT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:12:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fPyjLDJREwCkVz2P3y+NGXWaKWLccJVGwvhY6acD5abcGGPEW8UhwhE0yQS6TjIrgYm95TXv+MydFI6xgnjdR4lb9xjK+xcgrQFUvr0UB68znR+UcpPOc65If7zXbYtePl7ZayVdBn8AGvGzCYBnNDadupURR92B4vpzTgcqn+A=
Message-ID: <12c511ca0510291812y20df2a71n1eea45d7da49a1c7@mail.gmail.com>
Date: Sat, 29 Oct 2005 18:12:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: New (now current development process)
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	 <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
	 <20051029195115.GD14039@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/05, Linus Torvalds <torvalds@osdl.org> wrote:
> But to hit that, we'd might need to shrink the "merge window" from two
> weeks to just one, otherwise there's not enough time to calm down.

The problem with just one week to merge would be if other stuff
happened that ate up the merge period (e.g. this coming week I'm
travelling and will spend all day Tuesday and Wednesday in meetings).

It would be easier to manage if I could be sure which week was going
to be the merge window ... but I know that it is hard to predict when
a release will happen.  Overall I'd be much happier sticking with a
two week window.

-Tony
