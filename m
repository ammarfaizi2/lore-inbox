Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271622AbTGRMPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270237AbTGRMPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:15:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5772 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270230AbTGRMPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:15:33 -0400
Date: Fri, 18 Jul 2003 09:23:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
       riel@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
In-Reply-To: <20030718112758.1da7ab03.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
 <1058297936.4016.86.camel@tiny.suse.com> <Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
 <20030718112758.1da7ab03.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CCed lkml for obvious reasons

On Fri, 18 Jul 2003, Stephan von Krawczynski wrote:

> On Wed, 16 Jul 2003 08:37:51 -0300 (BRT)
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>
> >
> > Stephan, can you reproduce it easily?
>
> Hello,
>
> there is definitely something about it. pre6 froze after 2 days of
> testing. I guess I was unlucky this time with logfiles, no messages
> there.  There is something severe. You may call it reproducable, but not
> easy.

Stephan,

What is your workload?

I'll try to reproduce it.
