Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269846AbTGKIXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269836AbTGKIXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:23:31 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:5386 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269833AbTGKIVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:21:49 -0400
Date: Fri, 11 Jul 2003 09:36:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030711093621.A21196@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
References: <3F0CBC08.1060201@pobox.com> <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva> <20030710085338.C28672@infradead.org> <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva> <1057840919.8027.19.camel@dhcp22.swansea.linux.org.uk> <20030710161553.C22512@infradead.org> <20030710190030.GC8678@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030710190030.GC8678@atrey.karlin.mff.cuni.cz>; from jack@suse.cz on Thu, Jul 10, 2003 at 09:00:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 09:00:30PM +0200, Jan Kara wrote:
> > 1) original 16 bit one, supported by all kernels <= 2.4
> > 2) first 32bit one, supported by 2.4-ac any many vendor trees, but never
> >    in mainline
>   Actually at least later SuSE kernels and -ac kernels support 3)...

And the latest 2.4.20-based Red Hat kernel (RH 7/8/9 errata) support
_only_ 3, and the 32bit ondisk quota format.

