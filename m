Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136314AbRD1BhF>; Fri, 27 Apr 2001 21:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136317AbRD1Bgs>; Fri, 27 Apr 2001 21:36:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136314AbRD1BgU>; Fri, 27 Apr 2001 21:36:20 -0400
Date: Fri, 27 Apr 2001 18:36:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.GSO.4.21.0104272127390.21109-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104271835480.1120-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Apr 2001, Alexander Viro wrote:
> 
> PS: last time I've separated that part of patch was a couple months
> ago. See if something similar to the variant below would be OK with
> you (I'll rediff it):

This one looks fine.

		Linus

