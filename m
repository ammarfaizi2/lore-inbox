Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbTFUIev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 04:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFUIev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 04:34:51 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:18963 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265093AbTFUIev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 04:34:51 -0400
Date: Sat, 21 Jun 2003 09:48:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Chris Mason <mason@suse.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffer_insert_list should use list_add_tail
Message-ID: <20030621094846.A4080@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nathan Scott <nathans@sgi.com>, Chris Mason <mason@suse.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <1056028538.6757.94.camel@tiny.suse.com> <20030619231117.GB722@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030619231117.GB722@frodo>; from nathans@sgi.com on Fri, Jun 20, 2003 at 09:11:17AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 09:11:17AM +1000, Nathan Scott wrote:
> hi Chris,
> 
> We noticed this too and Christoph made this change in the
> 2.4 XFS tree a little while ago - let me check dates - ah,
> 9th May.  So, fair bit of testing here and we've not seen
> any issues from this change either (we'd also like to see
> it merged).

It's already in 2.5 for a long time and -ac since the XFS merge, too/

