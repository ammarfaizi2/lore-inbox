Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTIWT0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTIWTYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:24:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36572 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263502AbTIWTXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:23:44 -0400
Date: Tue, 23 Sep 2003 12:10:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, kevin.vanmaren@unisys.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923121044.483d3a5c.davem@redhat.com>
In-Reply-To: <16240.40001.632466.644215@napali.hpl.hp.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
	<20030923105712.552dbb1e.davem@redhat.com>
	<16240.36993.148535.613568@napali.hpl.hp.com>
	<20030923114744.137d5dac.davem@redhat.com>
	<16240.40001.632466.644215@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 12:17:21 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> Look, this may be difficult for you to understand, but different
> people find different policies useful.

You, sure.  But you are not the only user of the ia64 port just
as I am not the only user of the sparc64 port and if sparc64 generated
diagnostic messages not useful to people other than me I'd have to
quiet them by default.

All I'm suggesting is provide a way to control the kernel unaligned
accesses message and default it to off.
