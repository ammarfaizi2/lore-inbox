Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTFWCbH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 22:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFWCbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 22:31:06 -0400
Received: from granite.he.net ([216.218.226.66]:33541 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264966AbTFWCbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 22:31:04 -0400
Date: Sun, 22 Jun 2003 19:44:44 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] reimplement pci proc name
Message-ID: <20030623024444.GB5500@kroah.com>
References: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk> <20030620212413.GA13694@kroah.com> <20030621155333.A24141@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621155333.A24141@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 03:53:33PM +0400, Ivan Kokshaysky wrote:
> On Fri, Jun 20, 2003 at 02:24:13PM -0700, Greg KH wrote:
> > Thanks, I've reverted your previous patch, and fixed the one typo in
> > this patch and applied it all to my bk tree.  Hopefully Linus will pull
> > from it sometime soon :)
> 
> Argh, where were my eyes... There was another typo which broke Alpha.
> 
> Greg, please apply.

Applied, thanks.

greg k-h
