Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265450AbTFRUQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbTFRUQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:16:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:43934 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265450AbTFRUQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:16:25 -0400
Date: Wed, 18 Jun 2003 17:27:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
In-Reply-To: <20030617235838.GA2677@werewolf.able.es>
Message-ID: <Pine.LNX.4.55L.0306181719580.23915@freak.distro.conectiva>
References: <3EE66C86.8090708@free.fr> <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>
 <20030617235838.GA2677@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jun 2003, J.A. Magallon wrote:

>
> On 06.18, Marcelo Tosatti wrote:
> >
> >
> > On Wed, 11 Jun 2003, Eric Valette wrote:
> >
> > > Marcelo Tosati wrote:
> > >
> > >  >The main reason I didnt want to merge it was due to its size. Its just
> > >  >too big.
> > >
> > >  >> Please stop leading me along. Will you EVER merge it?
> > >
> > >  >Yes, I want to, and will merge it. In 2.4.23-pre.
> > >
> > > This kind of mails and sentence makes you lost your credibility :
> > > 	1) You said that ACPI will be merged in 2.4.22-pre,
> > > 	2) For many people ACPI (and aic7xxx) is top priority for 2.4 kernel
> > > (see various post including alan). The reason being that most laptop are
> > > unusable nowadays without ACPI,
> > > 	3) You do not explicitely says what you plan for 2.4.22...
> >
> > My plan for 2.4.22 is:
> >
> >  - Include the new aic7xxx driver.
> >  - Include ACPI. (I now realized its importance). Already discussing with
> >    Andrew the best way to do it.
> >  - Fix the latency/interactivity problems (Chris, Nick and Andrea working
> > on that)
> >  - Merge obviously correct -aa VM patches.
> >
> > Those are the most important things that are needed now, I think.
> >
>
> Would you accept small canges like -march (gcc_check) for x86 ?

I'm not aware of this patch. I might well accecpt it.

Please submit it with a good explanation and I will consider it.
