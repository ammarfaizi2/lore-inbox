Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTFTNxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFTNxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:53:30 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:36361 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262197AbTFTNx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:53:26 -0400
Date: Fri, 20 Jun 2003 18:06:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] reimplement pci proc name
Message-ID: <20030620180654.A1218@jurassic.park.msu.ru>
References: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Fri, Jun 20, 2003 at 02:48:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:48:11PM +0100, Matthew Wilcox wrote:
> I've implemented the original name for non-PCI-domain machines; done what
> ia64 and alpha need, respectively (assuming I didn't misunderstand Ivan)

You didn't. :-)
Looks fine to me, thanks.

Ivan.
