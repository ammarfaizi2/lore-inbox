Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVIGO0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVIGO0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVIGO0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:26:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48617 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751221AbVIGO0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:26:08 -0400
Date: Wed, 7 Sep 2005 15:26:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Yasushi SHOJI <yashi@atmark-techno.com>
Cc: linux-kernel@vger.kernel.org,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
Subject: Re: [PATCH] add romfs_get_size()
Message-ID: <20050907142604.GA5822@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Yasushi SHOJI <yashi@atmark-techno.com>,
	linux-kernel@vger.kernel.org,
	Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
References: <87k6htt0tg.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6htt0tg.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 11:22:19PM +0900, Yasushi SHOJI wrote:
> Many embedded linux products have been using romfs and it's still
> growing.  most, if not all, of them implement thier own way to check
> its romfs size.
> 
> this patch provides this commonly used function.

Used where.  Please come back as soon as you have a caller in-tree
which makes sense..
