Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRDWJab>; Mon, 23 Apr 2001 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRDWJaV>; Mon, 23 Apr 2001 05:30:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9988 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131669AbRDWJaI>; Mon, 23 Apr 2001 05:30:08 -0400
Subject: Re: All architecture maintainers: pgd_alloc()
To: miles@megapathdsl.net (Miles Lane)
Date: Mon, 23 Apr 2001 10:31:39 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), rmk@arm.linux.org.uk (Russell King),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0104222156180.6639-100000@aerie.megapathdsl.net> from "Miles Lane" at Apr 22, 2001 09:59:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rch4-0007eH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, could you delegate any of this work?  Is it feasible to
> have you redirect some portion of the patch analysis and acceptance
> load to another person, other than Linus?  Obviously, if the rate

To be honest I get very little patch material I didnt want to track. I get
lots of patches that are wrong, misguided, or otherwise flawed. However
I want to see those patches so I can help get them fixed.

On the whole people seem to be fairly good at sending stuff to obvious 
maintainers. Sometimes I bounce a few on. Big global changes to vm/vfs I tend
to ignore because those kind of things tend to be stuff Linus cares a lot 
about getting right anyway.

Alan

