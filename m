Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUAIWMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUAIWMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:12:46 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:43533 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264890AbUAIWMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:12:45 -0500
Date: Sat, 10 Jan 2004 01:12:03 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jochen Friedrich <jochen@scram.de>, Jesse Barnes <jbarnes@sgi.com>,
       linux-kernel@vger.kernel.org, jeremy@sgi.com,
       linux-pci@atrey.karlin.mff.cuni.cz, Jame.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040110011203.A629@den.park.msu.ru>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com> <Pine.LNX.4.58.0401090833480.4454@localhost> <20040109202718.GB14165@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040109202718.GB14165@colo.lackof.org>; from grundler@parisc-linux.org on Fri, Jan 09, 2004 at 01:27:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 01:27:18PM -0700, Grant Grundler wrote:
> ia64, parisc, x86_64, sparc64, mips, (and a few others) also have IO MMUs.

Hmm, IOMMU *and* ISA slots? :-)

Ivan.
