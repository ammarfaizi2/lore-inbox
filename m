Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTKKXk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTKKXk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:40:56 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:15494 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263839AbTKKXkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:40:55 -0500
Subject: Re: Some thoughts about stable kernel development
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, marcelo.tosatti@cyclades.com
In-Reply-To: <20031109112604.613d385d.akpm@osdl.org>
References: <m3u15de669.fsf@defiant.pm.waw.pl>
	 <20031109112604.613d385d.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1068410045.29597.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 09 Nov 2003 20:34:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-11-09 at 19:26, Andrew Morton wrote:
> Well yes.  Two days after 2.4.20 was released we discovered a
> data-corrupting bug in ext3.  I had no means of delivering a fix for that
> apart from sticking a bunch of patches on my web page and making a lot of
> noise about it.
> 
> So there is a case for a "2.4.20-post1" release to address such things.

For 2.2 I kept changelogs and errata patches for any big problem. For
-ac its always been a bit simpler because -ac1 is in part 2.4.20-post1
so I had an unfair advantage over people. The other thing -ac did was a
new patch every 2-3 days. The more you get out the more feedback you get
back and the faster you take fixes (even small ones) the more
committment you get from other people in my experience.


