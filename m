Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264001AbUCZKZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264004AbUCZKZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:25:53 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:10252 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264001AbUCZKZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:25:52 -0500
Date: Fri, 26 Mar 2004 10:25:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfs patch for 2.6
Message-ID: <20040326102549.A4248@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
References: <1078867885.25075.1458.camel@watt.suse.com> <20040313131447.A25900@infradead.org> <1079191213.4187.243.camel@watt.suse.com> <20040313163346.A27004@infradead.org> <20040314140032.A8901@infradead.org> <1079277810.4183.249.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1079277810.4183.249.camel@watt.suse.com>; from mason@suse.com on Sun, Mar 14, 2004 at 10:23:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 10:23:31AM -0500, Chris Mason wrote:
> > P.S. this patch now kills 16 lines of kernel code summarized :)
> > 
> 
> It looks good, I'll give it a try.

ping?  I've seen you merged the old patch into the suse tree, and having
shipping distros with incompatible APIs doesn't sound exactly like a good
idea..

