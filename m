Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVFVJV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVFVJV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVFVHog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:44:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58055 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262828AbVFVFvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:51:38 -0400
Date: Wed, 22 Jun 2005 06:51:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050622055137.GA29064@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> git-ocfs
> 
>     The OCFS2 filesystem.  OK by me, although I'm not sure it's had enough
>     review.

I'll try to take a look next week.  A major blocker is that it's not
endian-clean yet.  Even if other review items where perfect that's something
preventing it from going to mainline completely.

