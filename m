Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269591AbUICJ5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269591AbUICJ5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269610AbUICJpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:45:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:32261 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269464AbUICJms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:42:48 -0400
Date: Fri, 3 Sep 2004 10:42:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, takata@linux-m32r.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-ID: <20040903104239.A3077@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, takata@linux-m32r.org,
	linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>; from akpm@osdl.org on Fri, Sep 03, 2004 at 01:48:11AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/
> 
> - Added the m32r architecture.  Haven't looked at it yet.

Just from looking at the diffstat and not actual code: the actual code:

 - it adds new drivers under arch/m32r instead of drivers/

