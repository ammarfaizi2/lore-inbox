Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272357AbTG3X7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272358AbTG3X7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:59:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46540 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272357AbTG3X7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:59:21 -0400
Date: Wed, 30 Jul 2003 16:54:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: szepe@pinerecords.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] place IPv4 netfilter submenu where it belongs
Message-Id: <20030730165452.5a7d131e.davem@redhat.com>
In-Reply-To: <20030730140813.GC4553@sunbeam.de.gnumonks.org>
References: <20030726200646.GF16160@louise.pinerecords.com>
	<20030727160942.647707d8.davem@redhat.com>
	<20030729042618.GL32673@louise.pinerecords.com>
	<20030729223802.1d670476.davem@redhat.com>
	<20030730140813.GC4553@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 16:08:13 +0200
Harald Welte <laforge@netfilter.org> wrote:

> On Tue, Jul 29, 2003 at 10:38:02PM -0700, David S. Miller wrote:
> > On Tue, 29 Jul 2003 06:26:18 +0200
> > Tomas Szepe <szepe@pinerecords.com> wrote:
> > 
> > > The only aim of the patch is to put most netfilter options
> > > in a dedicated submenu so that one can go tweaking the
> > > them right where they've enabled netfilter in the first
> > > place.
> > 
> > This looks fine to me.  Can I get an ACK from the netfilter
> > folks?
> 
> I also aggree with this change, please apply Tomas' second proposed
> patch.

Applied, thanks guys.
