Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUHSSTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUHSSTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUHSSTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:19:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:30983 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267165AbUHSSTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:19:23 -0400
Date: Thu, 19 Aug 2004 19:19:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Message-ID: <20040819191919.A11917@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	jmerkey@comcast.net, linux-kernel@vger.kernel.org,
	jmerkey@drdos.com
References: <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net>; from jmerkey@comcast.net on Thu, Aug 19, 2004 at 06:10:25PM +0000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 06:10:25PM +0000, jmerkey@comcast.net wrote:
> kallsyms in 2.6.8 is presenting module symbol tables with out of order
> addresses in 2.6.X.  This makes maintaining a commercial kernel debugger
> for Linux 2.6 kernels nighmareish.

Can you prove this debugger doesn't violate SGI's copyrights on KDB?
