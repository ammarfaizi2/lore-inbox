Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUJNVFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUJNVFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUJNVFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:05:02 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35307 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S264639AbUJNVEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:04:22 -0400
Date: Thu, 14 Oct 2004 23:03:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Woodhouse <dwmw2@infradead.org>
cc: David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <1097764251.318.724.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0410142256360.877@scrub.home>
References: <Pine.LNX.4.61.0410132346080.7182@scrub.home> 
 <1097626296.4013.34.camel@localhost.localdomain>  <1096411448.3230.22.camel@localhost.localdomain>
  <1092403984.29463.11.camel@bach> <20040810002741.GA7764@kroah.com> 
 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com> 
 <30797.1092308768@redhat.com>  <20040812111853.GB25950@devserv.devel.redhat.com>
  <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com> 
 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com> 
 <10345.1097507482@redhat.com>  <1097507755.318.332.camel@hades.cambridge.redhat.com>
  <1097534090.16153.7.camel@localhost.localdomain> 
 <1097570159.5788.1089.camel@baythorne.infradead.org>  <27277.1097702318@redhat.com>
 <16349.1097752349@redhat.com>  <Pine.LNX.4.61.0410141357380.877@scrub.home>
  <1097755890.318.700.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.61.0410141554330.877@scrub.home> <1097764251.318.724.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Oct 2004, David Woodhouse wrote:

> On Thu, 2004-10-14 at 16:22 +0200, Roman Zippel wrote:
> > Only a minority of people do cross compile kernels, most people compile 
> > kernel and modules on the same machine,
> 
> Do they? I spend half my life building kernels, and still only a tiny
> minority of my boxen are actually running kernels which were built
> locally.

Nice how you conclude from your habits to habits of other people, but why 
did you ignore the rest of my mail? The primary topic of this was module 
signing not compile habits.

bye, Roman
