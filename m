Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbUCKDDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 22:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUCKDDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 22:03:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40076 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262973AbUCKDCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 22:02:33 -0500
Message-ID: <404FD6BC.7090409@pobox.com>
Date: Wed, 10 Mar 2004 22:02:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jouni Malinen <jkmaline@cc.hut.fi>
CC: jt@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com> <404F5744.1040201@pobox.com> <20040311024816.GC3738@jm.kir.nu>
In-Reply-To: <20040311024816.GC3738@jm.kir.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jouni Malinen wrote:
> I'm going to be at the IEEE 802.11 meeting for the next week which is
> probably going to take more or less all of my time, but I should be able
> to allocate more time after that. If people are interested in reviewing
> the current Host AP code from the viewpoint of what would need to happen
> before it can be merged into the kernel tree, the latest version is
> available as a snapshot from my CVS tree (pserver or tarball) at
> http://hostap.epitest.fi/. The current version is almost 20k lines, so
> there is certainly quite a bit of code to review. I hope to get this to
> about 15k lines, though, with the crypto API and backwards
> compatibility cleanup.

How about submitting a patch, when the CryptoAPI and backcompat cleanups 
are complete?  I will apply to the wireless-2.6 tree, and we can start 
working on the kernel's overall 802.11 support from there.  I don't 
pretend to be an 802.11 expert, so I'll let you and Jean and other 
developers drive that end of things.  I'm mainly interested in keeping 
the API simple and clean, and maintainable.

	Jeff



