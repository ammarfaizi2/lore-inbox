Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSLBUZR>; Mon, 2 Dec 2002 15:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSLBUZQ>; Mon, 2 Dec 2002 15:25:16 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:14862 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265002AbSLBUZP>; Mon, 2 Dec 2002 15:25:15 -0500
Date: Mon, 2 Dec 2002 20:32:33 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCh} FBDev: rivafb port
In-Reply-To: <1038467725.1092.42.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212022032000.18805-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. Added full hardware acceleration (should be 3 - 4x faster thant 2.4
> version with the putcs optimization.)
> 2. Added hardware cursor support
> 3. Fixed wrong color at depths > 8bpp, at least for the Riva128.

Applied but not tested. I can tets it out tonight when I get home.

