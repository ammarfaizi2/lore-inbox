Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSGQQUK>; Wed, 17 Jul 2002 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSGQQUJ>; Wed, 17 Jul 2002 12:20:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28800 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315370AbSGQQUI>;
	Wed, 17 Jul 2002 12:20:08 -0400
Date: Wed, 17 Jul 2002 09:19:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  July 17, 2002
In-Reply-To: <Pine.LNX.4.33L2.0207170908060.29653-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0207170916360.2542-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Randy.Dunlap wrote:

> On Wed, 17 Jul 2002, Guillaume Boissiere wrote:
> 
> | New week, new status update...
> | The details are at http://www.kernelnewbies.org/status/
> |
> | With the code freeze date approaching soon, it is obvious that many
> Oct. 31 is feature freeze date, or so several of us understood.

That is correct. And, for a feature, we only need a header file to be in, 
right? ;)

> | o Started     Reorder x86 initialization                      (Dave Jones,
> | Randy Dunlap)
> 
> Please change this one to Pat Mochel.

Please don't. While it would be nice if x86 init were a bit nicer, and 
things like CPUs were added in a 'hotpluggable' manner, I won't be 
dedicating time to this. At least not in near future...

	-pat

