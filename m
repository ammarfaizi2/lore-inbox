Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274255AbRJJOSS>; Wed, 10 Oct 2001 10:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJJOSI>; Wed, 10 Oct 2001 10:18:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38638 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274255AbRJJORz>;
	Wed, 10 Oct 2001 10:17:55 -0400
Date: Wed, 10 Oct 2001 10:18:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Woodhouse <dwmw2@infradead.org>
cc: Keith Owens <kaos@ocs.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
In-Reply-To: <4527.1002723183@redhat.com>
Message-ID: <Pine.GSO.4.21.0110101016120.17790-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, David Woodhouse wrote:

> 
> kaos@ocs.com.au said:
> > David Woodhouse <dwmw2@infradead.org> wrote:
> > > BSD-licensed modules shouldn't mark the kernel as tainted. If they do, 
> > > that's surely a bug.
> 
> >  Any license not listed in include/linux/module.h is not GPL
> > compatible. That list is currently (2.4.11) 
> 
> In the world I live in,  the BSD licence without the advertising clause is
> GPL compatible.

So is LGPL, for that matter.  And yes, it _does_ make sense, especially
for headers.

