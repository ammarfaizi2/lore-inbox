Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265422AbSJSA2U>; Fri, 18 Oct 2002 20:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSJSA2U>; Fri, 18 Oct 2002 20:28:20 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:49679 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265422AbSJSA2T>; Fri, 18 Oct 2002 20:28:19 -0400
Date: Sat, 19 Oct 2002 01:34:15 +0100
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021019003415.GA17016@compsoc.man.ac.uk>
References: <20021017011623.GA9096@compsoc.man.ac.uk> <20021016.181213.35446337.davem@redhat.com> <20021019002645.GA16882@compsoc.man.ac.uk> <20021018.172327.11877875.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018.172327.11877875.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *182hZH-000C4B-00*JQEnT0qsHjo* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:23:27PM -0700, David S. Miller wrote:

> Wouldn't that someone be you?  It's not that hard to code, and if
> it's in there from the start it would really save all of us a lot
> of time.

I'm a 64-bit moron: is there a standard way to determine this ?

Or do I add /dev/oprofile/sizeof or whatever ?

thanks
john

-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
