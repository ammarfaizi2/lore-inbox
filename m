Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbSLMATE>; Thu, 12 Dec 2002 19:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267562AbSLMATE>; Thu, 12 Dec 2002 19:19:04 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:8977 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267560AbSLMATD>; Thu, 12 Dec 2002 19:19:03 -0500
Date: Fri, 13 Dec 2002 00:26:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [PATCH 2.4.20] vanilla 3c59x
Message-ID: <20021213002651.A15922@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <3DF925AC.4020703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF925AC.4020703@pobox.com>; from jgarzik@pobox.com on Thu, Dec 12, 2002 at 07:11:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 07:11:24PM -0500, Jeff Garzik wrote:
> 
> 	bk pull bk://kernel.bkbits.net/jgarzik/3c59x-2.4
> 
> This will update the following files:

Marcelo, please don't pull that.  Having the pci-scan* junk in mainline
is bogus.
