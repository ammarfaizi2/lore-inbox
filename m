Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVATT4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVATT4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVATTzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:55:16 -0500
Received: from holomorphy.com ([66.93.40.71]:16089 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261905AbVATTxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:53:19 -0500
Date: Thu, 20 Jan 2005 11:50:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] unexport profile_pc
Message-ID: <20050120195002.GN8896@holomorphy.com>
References: <20050120182019.GJ3174@stusta.de> <20050120185917.GM8896@holomorphy.com> <20050120193938.GA9109@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120193938.GA9109@infradead.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:59:17AM -0800, William Lee Irwin III wrote:
>> In theory, /proc/ can be modular. In practice...

On Thu, Jan 20, 2005 at 07:39:38PM +0000, Christoph Hellwig wrote:
> Not even in theory.

I have vague recollections of modular /proc/ "fixes" being posted.
I don't have any vested (or other) interest in the thing being modular
and generally avoid modules altogether myself. fs/Kconfig of course
reveals that this "option" has since been removed, to my complete
indifference.


-- wli
