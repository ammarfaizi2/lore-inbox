Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTIXARN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTIXARN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:17:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26591 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261151AbTIXARJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:17:09 -0400
Date: Tue, 23 Sep 2003 17:04:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: Grant Grundler <iod00d@hp.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923170408.0a76e68f.davem@redhat.com>
In-Reply-To: <20030924001333.GD10490@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<20030923185104.GA8477@cup.hp.com>
	<20030923115122.41b7178f.davem@redhat.com>
	<20030923203819.GB8477@cup.hp.com>
	<20030923134529.7ea79952.davem@redhat.com>
	<20030923223540.GA10490@cup.hp.com>
	<20030923163542.55fd8ed9.davem@redhat.com>
	<20030924001333.GD10490@cup.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 17:13:33 -0700
Grant Grundler <iod00d@hp.com> wrote:

> It might. I be happy to share what I know about i860/i960 over pizza.
> I worked on ATT SVR4 port to i860 in 1989/90 and things were quite
> different then...

Q: How does an OS context switch work on the i860?
A: The user sneezes and the kernel cleans up after it.

I've hung out with i860 hackers already in my past :)
