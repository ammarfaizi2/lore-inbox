Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTBJVrU>; Mon, 10 Feb 2003 16:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbTBJVrU>; Mon, 10 Feb 2003 16:47:20 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:8115
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S265238AbTBJVrO>; Mon, 10 Feb 2003 16:47:14 -0500
Date: Mon, 10 Feb 2003 16:55:52 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Testing new starfire driver for 2.5
In-Reply-To: <43090000.1044848052@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302101650440.3127-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Martin J. Bligh wrote:

> I've been using your new starfire driver for a couple of weeks now,
> and it's in 2.5-mjb ... been testing on the 16x NUMA-Q w/16Gb RAM.
> 
> Not only does it work just fine with no problems, all the wierd error
> messages I had before went away ;-)

Good to hear that...

Which version did you end up using: 1.4.0 or 1.3.9?

> Seems cool to me, are you ready to push this to Linus?

Well, 1.3.9 is already in Marcelo's tree. I'll push 1.4.1 -- which is 
1.4.0 plus a compile option for enabling/disabling NAPI -- to Linus as 
soon as I finish testing with both compile options.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

