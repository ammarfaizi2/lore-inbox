Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275822AbRJJN7I>; Wed, 10 Oct 2001 09:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275806AbRJJN6w>; Wed, 10 Oct 2001 09:58:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4048 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275798AbRJJN6b>;
	Wed, 10 Oct 2001 09:58:31 -0400
Date: Wed, 10 Oct 2001 09:59:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: David Woodhouse <dwmw2@infradead.org>,
        "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
In-Reply-To: <13388.1002721848@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0110100956420.17790-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, Keith Owens wrote:

> On Wed, 10 Oct 2001 09:20:58 +0100, 
> David Woodhouse <dwmw2@infradead.org> wrote:
> >BSD-licensed modules shouldn't mark the kernel as tainted. If they do, 
> >that's surely a bug.
> 
> Any license not listed in include/linux/module.h is not GPL compatible.
> That list is currently (2.4.11)
> 
> "GPL"                           [GNU Public License v2 or later]
> "GPL and additional rights"     [GNU Public License v2 rights and more]
> "Dual BSD/GPL"                  [GNU Public License v2 or BSD license choice]
> "Dual MPL/GPL"                  [GNU Public License v2 or Mozilla license choice]

What the hell?  BSD without advertisement clause had always been
GPL-compatible.

