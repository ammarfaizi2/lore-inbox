Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVATTjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVATTjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVATTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:39:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62131 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261822AbVATTjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:39:43 -0500
Date: Thu, 20 Jan 2005 19:39:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] unexport profile_pc
Message-ID: <20050120193938.GA9109@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050120182019.GJ3174@stusta.de> <20050120185917.GM8896@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120185917.GM8896@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:59:17AM -0800, William Lee Irwin III wrote:
> On Thu, Jan 20, 2005 at 07:20:19PM +0100, Adrian Bunk wrote:
> > I haven't found any modular usage of profile_pc in the kernel.
> > Is the patch below correct?
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> In theory, /proc/ can be modular. In practice...

Not even in theory.

