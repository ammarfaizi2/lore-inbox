Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUHRUmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUHRUmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUHRUjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:39:37 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:7780 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267447AbUHRUjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:39:00 -0400
Message-ID: <45ae90370408181338680f71bd@mail.gmail.com>
Date: Wed, 18 Aug 2004 16:38:51 -0400
From: Jeff Macdonald <macfisherman@gmail.com>
Reply-To: Jeff Macdonald <macfisherman@gmail.com>
To: Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>
Subject: Re: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       opengfs-devel@lists.sourceforge.net,
       Daniel Phillips <phillips@istop.com>,
       opengfs-users@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       opendlm-devel@lists.sourceforge.net
In-Reply-To: <20040816192602.GA467@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net>
	<200408011330.01848.phillips@istop.com>
	<410D2949.20503@backtobasicsmgmt.com> <20040816192602.GA467@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 21:26:02 +0200, Pavel Machek <pavel@ucw.cz> wrote:
<snip>

> Remote character devices seem extremely usefull to me...
> 
> mpg456 --device /dev/kitchen/dsp
> 
> cat /dev/roof/dsp > /dev/laptop/dsp
> 
> cat picture-to-scare-pigeons.raw > /dev/roof/fb0
> 
> X --device=/dev/livingroom/fb0
> 
> ..... Okay, it will probably take a while until SSI cluster is the
> right tool to network your home :-).

Isn't that what Inferno is suppose to be able to do?

-- 
Jeff Macdonald
Ayer, MA
