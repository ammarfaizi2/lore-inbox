Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUJTPkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUJTPkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268411AbUJTPgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:36:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43736 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268397AbUJTPf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:35:59 -0400
Date: Wed, 20 Oct 2004 17:35:21 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Timothy Miller <miller@techsource.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20041020153521.GB21556@devserv.devel.redhat.com>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <41768858.8070709@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41768858.8070709@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:46:32AM -0400, Timothy Miller wrote:
> The rules about how long a hard irq would be allowed to run would have 
> to be draconian.

they already are.
