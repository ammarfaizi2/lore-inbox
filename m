Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbTLaEdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266111AbTLaEdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:33:33 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:59052 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266110AbTLaEdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:33:32 -0500
Subject: Re: 2.6.0: atyfb broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: claas@rootdir.de, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031230200653.7bc8a8cf.akpm@osdl.org>
References: <20031230212609.GA4267@rootdir.de>
	 <20031230200653.7bc8a8cf.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1072845181.716.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Dec 2003 15:33:01 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ben, if you could shoot me over a copy of the current linux-fbdev tree that
> might help things along a bit.

linux-fbdev is at bk://fbdev.bkbits.net/fbdev-2.5

Some things in there are too crappy though, like the whole gfx-client
stuff, I suggest you don't merge as-is. I will start sending you
patches tomorrow hopefully.

Ben.


