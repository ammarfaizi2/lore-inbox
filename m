Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132255AbRARP7D>; Thu, 18 Jan 2001 10:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135592AbRARP6y>; Thu, 18 Jan 2001 10:58:54 -0500
Received: from stud3.tuwien.ac.at ([193.170.75.13]:53775 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S132255AbRARP6n>; Thu, 18 Jan 2001 10:58:43 -0500
Date: Thu, 18 Jan 2001 16:58:30 +0100 (MET)
From: Stefan Ring <e9725446@student.tuwien.ac.at>
To: Joel Franco Guzmán <joel@gds-corp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
In-Reply-To: <Pine.LNX.4.30.0101181330390.1017-100000@thor.gds-corp.com>
Message-ID: <Pine.HPX.4.10.10101181656260.115-100000@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I know that increasing the number of DIMMs on your board will require
> > speedier RAMs on ASUS boards with some sort of an i440 chipset. This may
> > well be the case for just about every other MB, it's only that I don't
> > know specifically about these other boards.
> 
> This means that a modules will work at more high MHZ?

I said that you need faster (better) RAMs for the same bus speed when you
put more modules in. I could also say that you might have to lower the bus
speed so your RAMs keep up.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
