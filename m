Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132049AbRDDTkA>; Wed, 4 Apr 2001 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132046AbRDDTjv>; Wed, 4 Apr 2001 15:39:51 -0400
Received: from denise.shiny.it ([194.20.232.1]:32004 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S132042AbRDDTjj>;
	Wed, 4 Apr 2001 15:39:39 -0400
Message-ID: <3ACB7883.3DEBAD6A@denise.shiny.it>
Date: Wed, 04 Apr 2001 21:39:47 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: John William <jw2357@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2048 byte/sector problems with kernel 2.4
In-Reply-To: <F38vnbEG10Gai4omRXf000005a9@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >There WERE direct overwrite media for a while that would, in theory, be
> >able to write the data directly, but a combination of high cost, >limited
> >sources, and strong questions about the permanence of the recorded data
> >severely limited the demand for these and I think that they have been
> >withdrawn.

I have 2 OW disks and they work just fine. According to specs their
reliability is the same as nornal MO disks.

> No, direct overwrite disks are expensive, but they are still available. I do
> not know of any, and have not heard of any problems related to direct
> overwrite technology. For some reason M/O never really caught on in the US,
> and the high price of direct overwrite disks is what seems to be killing
> them off. I have a bunch I use for backup and have never had any problems.

RW CDs killed almost all removables.

And about 2KB sectors related problems, I confirm what I wrote in my previous
message: I have no problems. 640MB and 1.3GB both work fine here.

(kernel 2.4.3, old aic7xxx driver, adaptec 2930CU, Fujitsu GigaMO, PowerPC
750)

Bye.
