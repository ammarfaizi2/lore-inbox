Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263133AbVGNUJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVGNUJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbVGNUGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:06:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12170 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263133AbVGNUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:04:15 -0400
Date: Thu, 14 Jul 2005 21:04:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, rminnich@lanl.gov,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: (v9fs) -mm -> 2.6.13 merge status
Message-ID: <20050714200408.GA23092@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Andrew Morton <akpm@osdl.org>, rminnich@lanl.gov,
	linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
References: <20050620235458.5b437274.akpm@osdl.org> <20050627201944.GA22629@infradead.org> <a4e6962a050713112363010124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a050713112363010124@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 01:23:24PM -0500, Eric Van Hensbergen wrote:
> Sorry I didn't get to these quicker - was on vacation and basically
> off-line for the past week and a half.  I've made 90% of the changes
> suggested and committed them to my git tree, I'll combine the changes
> into a single patch and then split them by file-group before sending

normally we prefer a patch per actual change, not per file so the
description fits.  Given that all these are pretty trivial fixes one
patch would have done it aswell, though.

With these changes the code is fine for mainline in my opinion.

