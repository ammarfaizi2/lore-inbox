Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUAEWNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUAEWNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:13:37 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:51463 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265922AbUAEWNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:13:30 -0500
Date: Mon, 5 Jan 2004 22:13:28 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: S Ait-Kassi <sait-kassi@zonnet.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [update]  Vesafb problem since 2.5.51
In-Reply-To: <200401040111.58331.sait-kassi@zonnet.nl>
Message-ID: <Pine.LNX.4.44.0401052211570.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm directing it directly to the developers of the framebuffer layer and to 
> you specifically since you were involved with most of the changes in 2.5.51.
> 
> I have attached grabbed framebuffer distortion pics (png) since I think those 
> speak clearer than my previous attempts to put the problem into words through 
> the mailing list. 

Please try my latest patch. I tested midnight commander on my system and 
my system is okay. This is using the vesa framebuffer. 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz



