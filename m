Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSGQTQS>; Wed, 17 Jul 2002 15:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSGQTQS>; Wed, 17 Jul 2002 15:16:18 -0400
Received: from ns.suse.de ([213.95.15.193]:38417 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316491AbSGQTQQ>;
	Wed, 17 Jul 2002 15:16:16 -0400
Date: Wed, 17 Jul 2002 21:19:07 +0200
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 17, 2002
Message-ID: <20020717211907.H18170@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Patrick Mochel <mochel@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0207170908060.29653-100000@dragon.pdx.osdl.net> <Pine.LNX.4.44.0207170916360.2542-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207170916360.2542-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 09:19:39AM -0700, Patrick Mochel wrote:

 > > | With the code freeze date approaching soon, it is obvious that many
 > > Oct. 31 is feature freeze date, or so several of us understood.
 > 
 > That is correct. And, for a feature, we only need a header file to be in, 
 > right? ;)

Hmmmmmm 8-)
wrt to post-halloween features, things like new drivers that require no
core changes aren't an issue, but things like ripping out the VM and
replacing with a new one should probably wait until 2.6.10 or so.[*]

 > Please don't. While it would be nice if x86 init were a bit nicer, and 
 > things like CPUs were added in a 'hotpluggable' manner, I won't be 
 > dedicating time to this. At least not in near future...

Rusty seems to have a good handle on the hotplug bits, whether
bringing them up in a hotplug manner is his intention I'm not sure,
but it does seem to be going in that direction afaics.

        Dave

[*] j/k of course. (at least, I hope so).

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
