Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTIXCAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTIXCAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:00:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14816 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261245AbTIXCAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:00:32 -0400
Date: Tue, 23 Sep 2003 18:47:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, alan@lxorguk.ukuu.org.uk, tony.luck@intel.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923184729.26d02bea.davem@redhat.com>
In-Reply-To: <16240.47156.771134.68028@napali.hpl.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<1064350834.11760.4.camel@dhcp23.swansea.linux.org.uk>
	<16240.47156.771134.68028@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 14:16:36 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> Red Hat users won't be bothered by unaligned messages.

Let's hope they don't need to see anything useful in the dmesg output.
