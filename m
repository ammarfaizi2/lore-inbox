Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbUJZDUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbUJZDUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUJZCxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:53:37 -0400
Received: from mproxy.gmail.com ([216.239.56.245]:2550 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261998AbUJZCgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:36:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nTTpNlz1Wco7Mx+k313jMdetNxfhtakXX47YxTsSgU7ZZpPW5zwk7osTNOOpznxOyj7z/JTe7S3AmDBm9ou4ZPKNlvLZ/gEIZ16C4gMScIofdhxaujVH4E+p6xz4gC7gBXZLpHOYh1QVhzmTg/zekY2jmWjs5xhK9ciJqRURy+g=
Message-ID: <21d7e997041025193640d0c351@mail.gmail.com>
Date: Tue, 26 Oct 2004 12:36:52 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Kendall Bennett <kendallb@scitechsoft.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4177ABC9.24323.20E9CA71@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4176E08B.2050706@techsource.com>
	 <Pine.LNX.4.60.0410201521310.17443@dlang.diginsite.com>
	 <4177ABC9.24323.20E9CA71@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wrong. Companies *have* tried to go down the Open Source route and it did
> not work out for them. ATI in particular. At one point ATI released all
> the register level information and in fact released sample 3D driver
> source code to the community for the early Radeon chipsets. Unfortunately
> the Linux and Open Source community never stepped up to the plate to
> support ATI in this effort. There are solid business reasons that ATI has
> explained to me for why ATI decided to give up on the Open Source
> approach and go back to proprietary 3D drivers for Linux.

That's crap, the community did step up, the Weather Channel paid for
the r200 drivers we have now, ATI's register information was far short
of complete, I have the full stack of it here and it doesn't allow a
proper implementation of any of the "cool" features, i.e. hyper-z,
programmable hardware, so how could open source driver be as good if
they info they give is substandard.....  to be honest if a company
wants to do open source drivers for their cards they should support
it, with people, they didn't try at all,

they can try and hide behind it was the communitys fault all they
want, but it's crap I'd rather you didn't spread around here....

> For 2D they continue to maintain XFree86/X.org drivers with full source
> code for the community, just not 3D.

and the difference is?? their current 3D closed source drivers are
crap they know it, the community knows it, if they had open sourced a
completed driver 6-8mths ago, it would now work with X 6.8.1, Linux
2.6.9, powerpc, x86-64 and may even support doom3, and they wouldn't
have to had done anything for that, these big companies have to meet
the community half way, give us a complete working x86 driver for an
up-to-date X and someone will probably be interested in keeping it
running until the end of time... look at the (r300.sf.net to see how
much effort some people are willing to put into reverse engineering
the r300 3d parts...)

ATI and Nvidia not open-sourcing 3D stuff for one simple reason, IP
issues. It is also why Intel are not even giving out their later
chipsets docs to anyone by Tungsten, if anyone tells you differently
send them to me :-)

Dave.
