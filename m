Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTIIITY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 04:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTIIITY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 04:19:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53714 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263515AbTIIITX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 04:19:23 -0400
Date: Tue, 9 Sep 2003 01:08:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test4-mm5 and below: Wine and XMMS problems
Message-ID: <20030908230820.GG14800@fs.tum.de>
References: <20030902231812.03fae13f.akpm@osdl.org> <20030907100843.GM14436@fs.tum.de> <3F5B0AD2.3000706@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5B0AD2.3000706@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 08:39:14PM +1000, Nick Piggin wrote:
> 
> Hi Adrian,

Hi Nick,

> It would be great if you could test the latest mm kernel (mm6 as of now
> I think), which has Con's latest stuff in it. You could also test my
> newest scheduler patch. Thanks for the feedback.

I didn't check -mm6 (I had a different problem with -mm6 and not that 
much time).

I tried plain test4 with your sched-rollup-v14 and I got these awful
slower sound like when wou manually retard a record.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

