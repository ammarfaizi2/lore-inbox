Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUJNWrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUJNWrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUJNWnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:43:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30700 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268130AbUJNWio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:38:44 -0400
Date: Fri, 15 Oct 2004 00:38:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Howells <dhowells@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules? 
In-Reply-To: <3401.1097793152@redhat.com>
Message-ID: <Pine.LNX.4.61.0410150037100.877@scrub.home>
References: <Pine.LNX.4.61.0410150002540.877@scrub.home> 
 <Pine.LNX.4.61.0410132346080.7182@scrub.home> <1096411448.3230.22.camel@localhost.localdomain>
 <1092403984.29463.11.camel@bach> <26280.1092388799@redhat.com>
 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
 <10345.1097507482@redhat.com> <1097507755.318.332.camel@hades.cambridge.redhat.com>
 <1097534090.16153.7.camel@localhost.localdomain>
 <1097570159.5788.1089.camel@baythorne.infradead.org> <27277.1097702318@redhat.com>
 <16349.1097752349@redhat.com> <Pine.LNX.4.61.0410141357380.877@scrub.home>
 <1097755890.318.700.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0410141554330.877@scrub.home> <1097764251.318.724.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0410142256360.877@scrub.home> <1097789060.5788.2001.camel@baythorne.infradead.org>
 <Pine.LNX.4.61.0410142331020.877@scrub.home> <1097790753.5788.2031.camel@baythorne.infradead.org>
  <3401.1097793152@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Oct 2004, David Howells wrote:

> Where do you do it in userspace? glibc? uclibc? insmod is too early and is not
> the only way modules are loaded.

What can the kernel that insmod can't do? How else do you want to load 
modules?

bye, Roman
