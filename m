Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSKCVx6>; Sun, 3 Nov 2002 16:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbSKCVx6>; Sun, 3 Nov 2002 16:53:58 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:25243 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262525AbSKCVx5>;
	Sun, 3 Nov 2002 16:53:57 -0500
Date: Sun, 3 Nov 2002 21:59:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103215920.GB733@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC56270.8040305@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:52:48PM -0500, Jeff Garzik wrote:

 > This is potentially becoming a FAQ...  I ran into this too, as did 
 > several people in the office.  People who compile custom kernels seem to 
 > run into this when they first jump into 2.5.x.  AT Keyboard support is 
 > definitely buried :/

Documentation isn't enough. It _has_ to be made simpler.
Its obvious that this is the #1 stumbling block to a 2.5 virgin right now.
I fell over it myself when I merged it, as did Linus I believe.
It's just not obvious enough.

Having it documented obviously isn't enough too. I covered this in
the document[*] I wrote last week, which got ~3000 direct hits, ~7000
or so on Linux-today, and god knows how many elsewhere.
(Either that, or my description of the problem sucked).

		Dave

[*] http://www.codemonkey.org.uk/post-halloween-2.5.txt

-- 
| Dave Jones.        http://www.codemonkey.org.uk
