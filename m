Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVLALcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVLALcG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVLALcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:32:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59603 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932146AbVLALcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:32:05 -0500
Date: Thu, 1 Dec 2005 11:31:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc3-mm1
Message-ID: <20051201113158.GE3958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051129203134.13b93f48.akpm@osdl.org> <20051130162324.GA15273@infradead.org> <1133392706.16726.91.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133392706.16726.91.camel@gaston>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 10:18:25AM +1100, Benjamin Herrenschmidt wrote:
> Aren't UARTs driven by this driver also compatible with the 8250 one ?

I don't think so. It's a pretty complicated "intelligent" serial board.

