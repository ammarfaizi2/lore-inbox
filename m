Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSIXA6e>; Mon, 23 Sep 2002 20:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSIXA6e>; Mon, 23 Sep 2002 20:58:34 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:31497 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S261504AbSIXA6d>; Mon, 23 Sep 2002 20:58:33 -0400
Date: Tue, 24 Sep 2002 11:07:59 +1000
From: john slee <indigoid@higherplane.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
Message-ID: <20020924010758.GB6675@higherplane.net>
References: <Pine.LNX.4.44.0209221830400.8911-100000@serv.suse.lists.linux.kernel> <Pine.LNX.4.44.0209221130060.1455-100000@home.transmeta.com.suse.lists.linux.kernel> <p734rchu8ny.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734rchu8ny.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 09:27:29PM +0200, Andi Kleen wrote:
> There is an old patch around from SGI that does exactly this. It is a
> very lightweight binary value tracer that has per CPU buffers. It
> traces using macros that you can easily add. It's called ktrace (not
> to be confused with Ingo's ktrace). I've been porting it for some time

and different again from *bsd ktrace?

The Ravenous Bugblatter Beast of Traal hits! -- More -- 
You hear the wailing of the Banshee... -- More --
The Christmas Tree hits! -- More --
You die...

(guessing here, i've not seen ingo's ktrace)

j.

-- 
toyota power: http://indigoid.net/
