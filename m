Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280606AbRKGIIG>; Wed, 7 Nov 2001 03:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280776AbRKGIH4>; Wed, 7 Nov 2001 03:07:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59022 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280606AbRKGIHt>;
	Wed, 7 Nov 2001 03:07:49 -0500
Date: Wed, 7 Nov 2001 03:07:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@alex.org.uk, Ricky Beam <jfbeam@bluetopia.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <200111070720.fA77KZB486967@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0111070226540.1402-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Nov 2001, Albert D. Cahalan wrote:

> /proc/*/stat signal info was changed from decimal to hex for
> a while.

And _THAT_ should be a reason for immediate and severe LARTing.
That (and wankfests with progress bars, yodda, yodda) needs to
be stopped.  But notice that switching to binary or doing
tags, etc. has nothing to that - same breakage will continue
with them unless you LART lusers who do it.  Which works (or
doesn't) regardless of API.

Random API changes (and as a flipside of the same, APIs that
had never been thought through) are crap and they should be
dealt with.  However, if you think that switching to binary
is going to make people think what they are doing... there's
a nice bridge I'd like to sell.

