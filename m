Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbTCYPyX>; Tue, 25 Mar 2003 10:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbTCYPyW>; Tue, 25 Mar 2003 10:54:22 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11525 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262692AbTCYPyW> convert rfc822-to-8bit; Tue, 25 Mar 2003 10:54:22 -0500
Date: Tue, 25 Mar 2003 10:59:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Jamie Lokier <jamie@shareable.org>, Eric Sandall <eric@sandall.us>,
       linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <20030320211404.GA410@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.3.96.1030325105607.1437A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, [iso-8859-1] Jörn Engel wrote:

> That shouldn't matter, most of the times. If you want to build the
> code, you have to [bg]unzip anyway, so there is no extra cost.
> And I have a hard time to think of a real-world application where you
> don't want to unpack but need to verify the signature.

My real world includes downloading a bunch of files and burning a CD to
move them to a test environment which is completely private and has no
external connections of any kind. I don't do all files that way, of
course, but that is the way at least half of the 2.5 kernels I've used
were moved to a machine which was non-production.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

