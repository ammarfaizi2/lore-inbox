Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUDGVt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbUDGVt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:49:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8109
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261187AbUDGVtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:49:53 -0400
Date: Wed, 7 Apr 2004 23:49:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback
Message-ID: <20040407214950.GP26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <68580000.1081372758@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68580000.1081372758@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 02:19:18PM -0700, Martin J. Bligh wrote:
>  Tuesday, April 06, 2004 00:16:41 +0200 Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > On Mon, Apr 05, 2004 at 03:35:23PM -0600, Eric Whiting wrote:
> >> 4G of virtual address is what we need. Virtual address space is why the -mmX
> >> 4G/4G patches are useful. In this application it is single processes (usually
> > 
> > Indeed.
> > 
> >> 3.5:1.5 appears to be a 2.4.x kernel patch only right?
> > 
> > Martin has a port for 2.6 in the -mjb patchset (though it only works
> > with PAE disabled but there are patches floating around to make it work
> > at not noticeable cost with PAE enabled too).
> 
> There's no such thing as 3.5:1.5. Do you mean 3.5:0.5? or 2.5:1.5? ;-)

I meant 3.5:0.5, that's the additional config option in 2.4-aa and in
your tree too IIRC.
