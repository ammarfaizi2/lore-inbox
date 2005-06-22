Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVFVIcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVFVIcB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVFVI17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:27:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262914AbVFVIXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:23:04 -0400
Date: Wed, 22 Jun 2005 09:22:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from being built
Message-ID: <20050622082253.GA4594@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@davemloft.net>, gregkh@suse.de,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050621222419.GA23896@kroah.com> <20050621.155919.85409752.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621.155919.85409752.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
> I know the rational behind this.
> 
> However, this does mean I do need to reinstall a couple
> debian boxes here to something newer before I can continue
> doing kernel work in 2.6.x on them.

I have half a dozend debian sarge,etch and sid boxes on various architectures
and they work just fine without devfs.

