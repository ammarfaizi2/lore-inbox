Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTLLAGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 19:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTLLAGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 19:06:44 -0500
Received: from fmr05.intel.com ([134.134.136.6]:41395 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261539AbTLLAGn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 19:06:43 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Date: Thu, 11 Dec 2003 16:06:18 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125E21E@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Thread-Index: AcPAQlZrfTfo8dT4SsqxC3kC/ON3KgAAS+TQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <gene.heskett@verizon.net>, "Matt Mackall" <mpm@selenic.com>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>
X-OriginalArrivalTime: 12 Dec 2003 00:06:19.0336 (UTC) FILETIME=[C4C91480:01C3C043]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Gene Heskett [mailto:gene.heskett@verizon.net]
> 
> inaky.perez-gonzalez@intel.com wrote:
> >>  include/linux/fuqueue.h |  451
> >> ++++++++++++++++++++++++++++++++++++++++++++++++
> >> include/linux/plist.h   |  197 ++++++++++++++++++++
> >>  kernel/fuqueue.c        |  220 +++++++++++++++++++++++
> >>  3 files changed, 868 insertions(+)
> >>
> >> +++ linux/include/linux/fuqueue.h	Wed Nov 19 16:42:50 2003
> >
> >I don't suppose you've run this feature name past anyone in
> > marketting or PR?
> 
> Obviously not...

So?

I am already asking for new names for whoever doesn't like
them, like me ... I have more interesting things to do than
looking for names.

Care to suggest any? :0]

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
