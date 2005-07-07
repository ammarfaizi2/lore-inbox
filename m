Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVGGNJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVGGNJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVGGNHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:07:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261441AbVGGNET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:04:19 -0400
Date: Thu, 7 Jul 2005 14:04:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [RFC] [PATCH 1/2] move truncate_inode_pages() into ->delete_inode()
Message-ID: <20050707130402.GB28489@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Fasheh <mark.fasheh@oracle.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20050706221803.GO8215@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706221803.GO8215@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 03:18:03PM -0700, Mark Fasheh wrote:
> Resending this series as I haven't heard anything back from anyone...
> If there's no objections, can we get this into -mm for some additional
> review and testing?

The patches are fine, thanks.

