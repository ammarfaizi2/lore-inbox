Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVFGABm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVFGABm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFGAA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:00:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:6798 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261784AbVFFX6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:58:52 -0400
Subject: Re: pci_enable_msi() for everyone?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net
In-Reply-To: <20050606230051.GC11184@suse.de>
References: <20050603224551.GA10014@kroah.com>
	 <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de>
	 <20050604070537.GB8230@colo.lackof.org> <20050604071803.GA13684@suse.de>
	 <1118008827.31082.245.camel@gaston>  <20050606230051.GC11184@suse.de>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 09:56:42 +1000
Message-Id: <1118102203.6850.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > Disagreed.
> 
> Disagreed in what way?  What's the bad side affects?

I'd rather have the driver decide wether to enable it or not
explicitely ... but heh, that's just my taste ...

Ben.


