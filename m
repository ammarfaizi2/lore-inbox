Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272759AbTG3Flr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272763AbTG3Flr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:41:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41415 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272759AbTG3Flq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:41:46 -0400
Date: Tue, 29 Jul 2003 22:38:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] place IPv4 netfilter submenu where it belongs
Message-Id: <20030729223802.1d670476.davem@redhat.com>
In-Reply-To: <20030729042618.GL32673@louise.pinerecords.com>
References: <20030726200646.GF16160@louise.pinerecords.com>
	<20030727160942.647707d8.davem@redhat.com>
	<20030729042618.GL32673@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 06:26:18 +0200
Tomas Szepe <szepe@pinerecords.com> wrote:

> Ok, what does this look like?
> 
> The only aim of the patch is to put most netfilter options
> in a dedicated submenu so that one can go tweaking the
> them right where they've enabled netfilter in the first
> place.

This looks fine to me.  Can I get an ACK from the netfilter
folks?

Thanks.
