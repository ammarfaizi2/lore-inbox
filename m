Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVHIA5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVHIA5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHIA5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:57:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932391AbVHIA5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:57:03 -0400
Date: Tue, 9 Aug 2005 02:56:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] Removing maintainer's bad e-mails
Message-ID: <20050809005659.GT4006@stusta.de>
References: <42F69E53.40602@gmail.com> <20050808183300.GB26182@redhat.com> <20050808224917.GP4006@stusta.de> <20050809003140.GJ7667@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809003140.GJ7667@kurtwerks.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 08:31:40PM -0400, Kurt Wall wrote:
> On Tue, Aug 09, 2005 at 12:49:17AM +0200, Adrian Bunk took 42 lines to write:
> > On Mon, Aug 08, 2005 at 02:33:00PM -0400, Dave Jones wrote:
> > > 
> > > You may as well change the S: to unmaintained whilst
> > > you're there, it hasn't seen any updates in a long time,
> > > and still uses several out-of-date SCSI APIs.
> > 
> > Or he could completely remove the entry.
> > 
> > We don't have entries for every single unmaintained driver, and the 
> > smaller MAINTAINERS is the higher is the possibility of not missing a 
> > relevant entry when checking whom to send an email.
> 
> Hmm, so if a subsystem or driver (more drivers, I should think) lacks
> an entry in MAINTAINERS, is it then reasonable to assume that it is
> unmaintained? If not, perhaps creating a separate list of unmaintained
> subsystems and/or drivers is prudent?

For unmaintained drivers or drivers maintained by the subsystem 
maintainers (which can be the reason why there's no entry for this 
driver) contact the subsystem maintainer.

Unmaintained subsystems are a problem.

I've already started contacting subsystem maintainers that seem to be 
inactive, and I have some restructuring of MAINTAINERS (tree structure 
with drivers behind subsystems) on my TODO list.

> Kurt

cu
Adrian

BTW: Please don't remove people from the Cc when answering.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

