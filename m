Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSGASnh>; Mon, 1 Jul 2002 14:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSGASnh>; Mon, 1 Jul 2002 14:43:37 -0400
Received: from msp-65-29-25-149.mn.rr.com ([65.29.25.149]:42627 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S316158AbSGASnf>; Mon, 1 Jul 2002 14:43:35 -0400
Date: Mon, 1 Jul 2002 13:45:28 -0500
From: Shawn <core@enodev.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
Message-ID: <20020701134528.A17724@q.mn.rr.com>
References: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com> <20020701184257.GC1762@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020701184257.GC1762@localhost>; from linux-kernel@24x7linux.com on Mon, Jul 01, 2002 at 08:42:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01, Jose Luis Domingo Lopez said something like:
> On Monday, 01 July 2002, at 13:48:55 -0400,
> Bill Davidsen wrote:
> 
> > The suggestion was made that kernel module removal be depreciated or
> > removed. I'd like to note that there are two common uses for this
> > capability, and the problems addressed by module removal should be kept in
> > mind. These are in addition to the PCMCIA issue raised.
> > 
> From my non-kernel non-programmer point of view, module removal can be
> useful under more circunstances than the ones you said. For example,
> trying some combination of parameters for a module to get you damned

How about simply upgrading a driver w/out rebooting?

--
Shawn Leas
core@enodev.com

I planted some bird seed.  A bird came up.  Now I don't know
what to feed it.
						-- Stephen Wright
