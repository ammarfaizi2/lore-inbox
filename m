Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262688AbTC0AMR>; Wed, 26 Mar 2003 19:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbTC0AMR>; Wed, 26 Mar 2003 19:12:17 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:34312 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262688AbTC0AMQ>; Wed, 26 Mar 2003 19:12:16 -0500
Date: Thu, 27 Mar 2003 00:23:27 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Wichert Akkerman <wichert@wiggy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [FIX] Re: 2.5.66 new fbcon oops while loading X
In-Reply-To: <20030326224245.GN2078@wiggy.net>
Message-ID: <Pine.LNX.4.44.0303270023040.25001-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Previously James Simmons wrote:
> > That is no longer true. The fb nodes should be recreated. I fixed the docs 
> > in devices.txt
> 
> Fine with me, however someone might want to look at the device numbering
> that the various Linux distros are using at this moment. I know Debian
> is using the old numbering and I just filed a bugreport to get that
> updated. I do expect a fair amount of people will run into this when
> they upgrade to 2.5/2.6 kernels.

Only if they have more than one video card which is pretty small number.


