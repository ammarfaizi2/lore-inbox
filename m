Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUBYSMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUBYSMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:12:46 -0500
Received: from verein.lst.de ([212.34.189.10]:6555 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261520AbUBYSMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:12:12 -0500
Date: Wed, 25 Feb 2004 19:11:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@redhat.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Please back out the bluetooth sysfs support
Message-ID: <20040225181159.GA15078@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@redhat.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1077560544.2791.63.camel@pegasus> <20040223184525.GA12656@lst.de> <1077582336.2880.12.camel@pegasus> <20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk> <20040223232149.5dd3a132.davem@redhat.com> <1077621601.2880.27.camel@pegasus> <20040224100325.761f48eb.davem@redhat.com> <1077650761.2919.42.camel@pegasus> <20040225001013.7c5e4a9b.davem@redhat.com> <1077730823.2919.133.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077730823.2919.133.camel@pegasus>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 06:40:24PM +0100, Marcel Holtmann wrote:
> if nobody else has complains about this patch I will test it a last time
> on a different machine and then drop you a note where you can pull it
> from.

Looks okay to me.

