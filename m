Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTLLDQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 22:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTLLDQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 22:16:03 -0500
Received: from fmr05.intel.com ([134.134.136.6]:42172 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264432AbTLLDQA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 22:16:00 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Date: Thu, 11 Dec 2003 19:15:40 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125E23B@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Thread-Index: AcPAW6QfhP0gE9GbTEG2mHhI37xSfAAAeY+w
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Matt Mackall" <mpm@selenic.com>
Cc: <gene.heskett@verizon.net>, <linux-kernel@vger.kernel.org>,
       <robustmutexes@lists.osdl.org>
X-OriginalArrivalTime: 12 Dec 2003 03:15:40.0642 (UTC) FILETIME=[38A6CC20:01C3C05E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Matt Mackall [mailto:mpm@selenic.com]


> > > From: Gene Heskett [mailto:gene.heskett@verizon.net]
> > >
> > > inaky.perez-gonzalez@intel.com wrote:
> > > >>  include/linux/fuqueue.h |  451
> > > >> ++++++++++++++++++++++++++++++++++++++++++++++++
> > > >> include/linux/plist.h   |  197 ++++++++++++++++++++
> > > >>  kernel/fuqueue.c        |  220 +++++++++++++++++++++++
> > > >>  3 files changed, 868 insertions(+)
> > > >>
> > > >> +++ linux/include/linux/fuqueue.h	Wed Nov 19 16:42:50 2003
> > > >
> > > >I don't suppose you've run this feature name past anyone in
> > > > marketting or PR?
> > >
> > > Obviously not...
> >
> > I am already asking for new names for whoever doesn't like
> > them, like me ... I have more interesting things to do than
> > looking for names.
> 
> The name's fine by me actually, I'm greatly looking forward to hearing
> someone present them at the next Linux Symposium.

I'll try to [at least I'll submit a proposal]...heh! :]
 
> Other people might not be so amused, though.

Do you mean on how similar it sounds to the famous four letter 
word that everybody seems to be afraid to say in public? :) 

Well, I had initially (and intentionally) fucvar for a conditional 
variable...however, in order to be more in order with how POSIX names
them, I changed it to fucond. 

Good thing they were not worth to implement (and actually swearing 
by them was a good thing, they were a real PITA).

Now seriously, forgive my naivete as English is my second language,
what might be not so amusing to others? the 'fuck' thingie?

Thx,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
