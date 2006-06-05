Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751319AbWFETTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWFETTj (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWFETTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:19:39 -0400
Received: from canuck.infradead.org ([205.233.218.70]:6076 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751312AbWFETTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:19:38 -0400
Subject: Re: header cleanup and install
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060605110928.35110000.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149456793.30024.21.camel@pmac.infradead.org>
	 <20060605105240.GB4400@suse.de>
	 <1149504858.30024.68.camel@pmac.infradead.org>
	 <20060605105925.GD4400@suse.de>
	 <1149505074.30024.70.camel@pmac.infradead.org>
	 <20060605110331.GE4400@suse.de>  <20060605110928.35110000.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 20:19:30 +0100
Message-Id: <1149535171.30024.157.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 11:09 -0700, Andrew Morton wrote:
> I'm not as shy.
> 
> David, we now have a mixture of "color" and "colour" in the same piece of
> code.  That's just dumb. 

I blame them damn Frenchies. Fixed in the git tree.

-- 
dwmw2

