Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUJOLMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUJOLMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267668AbUJOLMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:12:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:385 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267649AbUJOLMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:12:33 -0400
Date: Fri, 15 Oct 2004 13:12:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Howells <dhowells@redhat.com>
cc: "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules? 
In-Reply-To: <23446.1097777340@redhat.com>
Message-ID: <Pine.LNX.4.61.0410151253360.7182@scrub.home>
References: <27277.1097702318@redhat.com>  <1097626296.4013.34.camel@localhost.localdomain>
 <1096544201.8043.816.camel@localhost.localdomain> <1096411448.3230.22.camel@localhost.localdomain>
 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
 <20040812092029.GA30255@devserv.devel.redhat.com> <20040811211719.GD21894@kroah.com>
 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
 <30797.1092308768@redhat.com> <20040812111853.GB25950@devserv.devel.redhat.com>
 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
 <10345.1097507482@redhat.com> <1097507755.318.332.camel@hades.cambridge.redhat.com>
 <1097534090.16153.7.camel@localhost.localdomain>
 <1097570159.5788.1089.camel@baythorne.infradead.org>  <23446.1097777340@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Oct 2004, David Howells wrote:

> I've uploaded an updated module signing patch with Rusty's suggested
> additions:

Can someone please put this patch into some context, where it's not 
completely pointless? As is it does not make anything more secure.
Why is the kernel more trustable than a kernel module?
If someone could show me how I can trust the running kernel, it should be 
rather easy to extend the same measures to modules without the need for 
this patch.

bye, Roman
