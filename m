Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293708AbSCFRkE>; Wed, 6 Mar 2002 12:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293715AbSCFRjx>; Wed, 6 Mar 2002 12:39:53 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:25478 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S293708AbSCFRjc>;
	Wed, 6 Mar 2002 12:39:32 -0500
Date: Wed, 6 Mar 2002 12:36:24 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Ken Brownfield <brownfld@irridia.com>
cc: J Sloan <joe@tmsusa.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Recommendations about a 100/10 NIC
In-Reply-To: <20020306111502.D8107@asooo.flowerfire.com>
Message-ID: <Pine.SGI.4.31L.02.0203061234520.6241227-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Ken Brownfield wrote:

> Haven't had any issues at all with eepro100 or e100 under production
> load for years.  Since Tulip went out of the mainstream (poor Digital)
> the EtherExpress has been the most stable everywhere I've been.  I've
> written too many scripts for 3Com boxes that grep dmesg for "fatal"
> errors and unload/reload the 3com module.

Ran into problems with Intel EtherExpress cards under Alpha a while back,
and I've had a _lot_ of problems with the revision of the EtherExpress
built into motherboards, versus the intel or kernel drivers for them.

My stock recommendation is thus SMC EtherPower II cards.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

