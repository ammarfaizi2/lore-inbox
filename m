Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWCKAzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWCKAzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWCKAzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:55:07 -0500
Received: from mailgate1.uni-kl.de ([131.246.120.5]:33962 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP id S932351AbWCKAzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:55:06 -0500
Date: Sat, 11 Mar 2006 01:54:53 +0100
From: Eduard Bloch <edi@gmx.de>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-ID: <20060311005453.GA1494@debian>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> <200603091509.06173.luke@dashjr.org> <441057D4.6030304@cfl.rr.com> <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com> <1141928755.7599.0.camel@bip.parateam.prv> <161717d50603091222p34b45065xdb8507cbf8191a3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161717d50603091222p34b45065xdb8507cbf8191a3d@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Dave Neuer [Thu, Mar 09 2006, 03:22:29PM]:

> But I stand by my assertion: many kernel developers on record stating
> that they don't want their work used in binary-only modules, and the
> reason that this hasn't been decided by a court yet is no sufficiently
> deep-pocketed plaintiff (independantly wealthy kernel hackers or a big
> corporation with copyright interest in the kernel) has decided to sue,
> yet.

Strongly following this attitude they need to expand the current
MODULE_LICENSE insanity into userspace. The are lots of evil powers,
using non-GPL-ed software which calls the holy GPLed syscall handlers.

Honestly, using double standards this way sucks. The last strike I
stubled over was putting class device registration methods into the GPL
"enforcing" macros, cloacked as mandatory interface changes.

This is no longer funny, it is on the same level as drawing a line
around the toilet box and saying: you cannot use it any longer, go and
piss somewhere else even if you have to search two hours for a suitable
place.

Eduard.

-- 
Captain John Sheridan: No surrender, no retreat.
                                                 -- Quotes from Babylon 5 --
