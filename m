Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269393AbUH0J2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269393AbUH0J2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269387AbUH0JZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:25:46 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:48906 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269390AbUH0JYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:24:18 -0400
Date: Fri, 27 Aug 2004 10:24:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Christophe Saout <christophe@saout.de>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, hch@lst.de,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827102402.C29672@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>,
	Christophe Saout <christophe@saout.de>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
	torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <412DAC59.4010508@namesys.com> <1093548414.5678.74.camel@krustophenia.net> <1093548815.13881.10.camel@leto.cs.pocnet.net> <412EEB59.7010101@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412EEB59.7010101@namesys.com>; from reiser@namesys.com on Fri, Aug 27, 2004 at 01:05:45AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 01:05:45AM -0700, Hans Reiser wrote:
> Not necessarily.  We just encourage it....  Reiser4 is a body of code 
> that can be sliced and diced as you choose, and it is designed for easy 
> slicing.

So what about slicing it into a simple posix fs as a start so we can review
that while still discussing semantic issues.  Now that would be a refreshing
thing after all that talking, no?

