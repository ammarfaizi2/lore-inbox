Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270757AbTGNTZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270756AbTGNTZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:25:50 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:10511 "EHLO
	mail.truemesh.com") by vger.kernel.org with ESMTP id S270757AbTGNTZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:25:39 -0400
Date: Mon, 14 Jul 2003 20:34:14 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: philipwyett@dsl.pipex.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030714193414.GW28359@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Arjan van de Ven <arjanv@redhat.com>, philipwyett@dsl.pipex.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <20030714083058.GC3706@pern.dea.icai.upco.es> <20030714114144.GB5187@suse.de> <1058184785.5981.0.camel@laptop.fenrus.com> <1058186233.2561.9.camel@rh9> <1058191558.6024.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058191558.6024.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:05:58PM +0200, Arjan van de Ven wrote:
> On Mon, 2003-07-14 at 14:37, Philip Wyett wrote:
> > On Mon, 2003-07-14 at 13:13, Arjan van de Ven wrote:

> > > RHL9 rpms are at
 
> the plan is to put the requires helper packages up as well but the
> buildsystem isn't currently on friendly terms with me ;(
> to be there asap.

Hmm, any chance of putting the spec/patches and .configs split out to
minimise downloads for those of us who already have the kernel archive?

Things I note that aren't there yet (or in rawhide from what I can see),
an lvm2 package - but I imagine that'll come in time.  The ipsec-tools
are in rawhide, but what you provide should be good for getting people
up and running.

I like the combined modutils patch, that seems more user friendly.

Cheers 

Paul
