Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbUKHUYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUKHUYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUKHUYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:24:15 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:25354 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261198AbUKHUYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:24:13 -0500
Date: Mon, 8 Nov 2004 20:23:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] small IPMI cleanup
Message-ID: <20041108202358.GA28595@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Corey Minyard <cminyard@mvista.com>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20041106222839.GS1295@stusta.de> <418FB0EA.90006@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418FB0EA.90006@mvista.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 11:46:18AM -0600, Corey Minyard wrote:
> Adrian,
> 
> All these things are tools used by external modules that have not yet 
> made it into the mainstream kernel.  Also, there are other users of 
> these functions that are perhaps not in the kernel yet (and perhaps 
> never make it into the mainstream kernel).  Some of the statics do need 
> to be cleaned up, though.

That's not a valid reason at all.

