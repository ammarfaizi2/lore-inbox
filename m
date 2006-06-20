Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWFTUlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWFTUlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWFTUlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:41:13 -0400
Received: from mx.pathscale.com ([64.160.42.68]:58072 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750870AbWFTUlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:41:10 -0400
Date: Tue, 20 Jun 2006 13:41:09 -0700
From: Greg Lindahl <greg.lindahl@qlogic.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ak@suse.de, olson@unixfolk.com, discuss@x86-64.org, brice@myri.com,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060620204109.GA1980@greglaptop.internal.keyresearch.com>
Mail-Followup-To: "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
	olson@unixfolk.com, discuss@x86-64.org, brice@myri.com,
	linux-kernel@vger.kernel.org, gregkh@suse.de
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de> <20060620200352.GJ1414@greglaptop.internal.keyresearch.com> <20060620132049.ff5e6f67.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620132049.ff5e6f67.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.1i
X-Frumious: Bandersnatch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 01:20:49PM -0700, Randy.Dunlap wrote:

> Does it cover the 10 new models that are available tomorrow?
> (hypothetical question)

I see several people on this list who are aware of forthcoming PCI
Express server products, and they aren't objecting to broad
whitelisting of PCI Express.

Is there any known case of PCI Express and MSI not working on any
chipset? Andi, is the tg3 NIC that didn't work in a Supermicro system
on PCI-X or PCI Express?

-- greg


