Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293604AbSCPAim>; Fri, 15 Mar 2002 19:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSCPAic>; Fri, 15 Mar 2002 19:38:32 -0500
Received: from waste.org ([209.173.204.2]:4777 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S293602AbSCPAiO>;
	Fri, 15 Mar 2002 19:38:14 -0500
Date: Fri, 15 Mar 2002 18:37:26 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: David Gibson <david@gibson.dropbear.id.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Bjorn Wesen <bjorn.wesen@axis.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
In-Reply-To: <20020315023509.GB1289@zax>
Message-ID: <Pine.LNX.4.44.0203151830450.15926-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, David Gibson wrote:

> On Thu, Mar 14, 2002 at 05:49:15AM -0500, Jeff Garzik wrote:
> > Bjorn Wesen wrote:
> >
> > >Just a datapoint:
> > >
> > >The orinico driver (already in the kernel) works fine with the DWL-650
> > >card. Tried it some days ago.. not a very big field trial but I inserted
> > >the card and I got an eth0 from it and it worked, so thats the way I like
> > >it :)
> >
> >
> > Not "just" a datapoint, a useful one.  Thanks.
>
> Sadly not everybody is having as much luck.  A lot of people are
> reporting terribly throughput on Intersil cards like the DWL-650 and I
> haven't managed to track the problem down yet.

Here's some further datapoints:

Vaio Z505SX, kernels through 2.4.16 - works great
IBM T22, 2.4.16+sound, 2.4.17+lowlatency-sound - works great
T22, 2.4.18+ and 2.5.5 - 2-3K/s

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

