Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVDLUc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVDLUc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVDLUcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:32:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:1694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262235AbVDLSru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:47:50 -0400
Date: Tue, 12 Apr 2005 11:49:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
In-Reply-To: <1113330533.31159.43.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0504121147390.4501@ppc970.osdl.org>
References: <1113282436.21548.42.camel@gaston> <1113330533.31159.43.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Apr 2005, Lee Revell wrote:
> 
> Um... why in the heck are you posting this here instead of alsa-devel?

Which list do you think has more people interested? ppc64 or alsa?

Pretty much anybody with a G5 will probably be on the ppc lists. And 
_nobody_ will be on the alsa lists, since it historically has never had 
any sound at all.

In other words, don't believe that "sound" means that it must be an alsa 
list. Lists make sense not because of intent, but because of who they 
reach.

		Linus
