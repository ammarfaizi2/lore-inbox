Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135464AbRDWPo1>; Mon, 23 Apr 2001 11:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135401AbRDWPns>; Mon, 23 Apr 2001 11:43:48 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:2312 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S135456AbRDWPmW>;
	Mon, 23 Apr 2001 11:42:22 -0400
Date: Mon, 23 Apr 2001 08:32:34 -0700 (PDT)
From: Miles Lane <miles@megapathdsl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: All architecture maintainers: pgd_alloc()
In-Reply-To: <E14rch4-0007eH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0104230830200.27725-100000@aerie.megapathdsl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Alan Cox wrote:

> > Alan, could you delegate any of this work?  Is it feasible to
> > have you redirect some portion of the patch analysis and acceptance
> > load to another person, other than Linus?  Obviously, if the rate
>
> To be honest I get very little patch material I didnt want to track. I get
> lots of patches that are wrong, misguided, or otherwise flawed. However
> I want to see those patches so I can help get them fixed.

Obviously, there's huge value to the development community to get your
feedback on these flawed patches, as well.  It strengthens the entire
community.

> On the whole people seem to be fairly good at sending stuff to obvious
> maintainers. Sometimes I bounce a few on. Big global changes to vm/vfs I tend
> to ignore because those kind of things tend to be stuff Linus cares a lot
> about getting right anyway.

Yeah.  I sort of figured you'd shout if something really wasn't working.

Thanks Alan,

	Miles


