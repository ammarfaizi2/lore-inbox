Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSJSAeW>; Fri, 18 Oct 2002 20:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbSJSAeW>; Fri, 18 Oct 2002 20:34:22 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:44300 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265424AbSJSAeU>; Fri, 18 Oct 2002 20:34:20 -0400
Date: Sat, 19 Oct 2002 01:40:22 +0100
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021019004022.GC17016@compsoc.man.ac.uk>
References: <20021019002645.GA16882@compsoc.man.ac.uk> <20021018.172327.11877875.davem@redhat.com> <20021019003415.GA17016@compsoc.man.ac.uk> <20021018.173128.11570989.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018.173128.11570989.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:31:28PM -0700, David S. Miller wrote:

> I suspect oprofile won't be the only situation where this value
> would be useful, perhaps /proc/sys/kernel/pointer_size?

Super. I'll do so.

thanks
john

-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
