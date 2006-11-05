Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWKEFIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWKEFIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 00:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWKEFIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 00:08:40 -0500
Received: from ozlabs.org ([203.10.76.45]:60382 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030212AbWKEFIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 00:08:39 -0500
Subject: Re: [PATCH 1/7] paravirtualization: header and
	stubs	for	paravirtualizing critical operations
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <454D6FC7.3040308@vmware.com>
References: <20061029024504.760769000@sous-sol.org>
	 <200611030356.54074.ak@suse.de> <454BA7F7.8030205@vmware.com>
	 <200611032209.40235.ak@suse.de>
	 <1162701815.29777.6.camel@localhost.localdomain>
	 <454D6FC7.3040308@vmware.com>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 16:08:37 +1100
Message-Id: <1162703317.29777.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-04 at 20:59 -0800, Zachary Amsden wrote:
> Rusty Russell wrote:
> > Andi, the patches work against Andrew's tree, and he's merged them in
> > rc4-mm2.  There are a few warnings to clean up, but it seems basically
> > sound.
> >
> > At this point I our think time is better spent on beating those patches
> > up, rather than going back and figuring out why they don't work in your
> > tree.
> >   
> 
> This begs the question - should we rebase the paravirt-ops patchset 
> against -rc4-mm2?  I almost did it today, but didn't want to stomp on 
> anybody else's toes.

Yes.  Andrew has shot me a couple of warnings which people have found,
and I'm preparing patches for them.  Rebasing will make it easier.

If you're not awake now, I'll do it.  If you are, see me on IRC.

Rusty.


