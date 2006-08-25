Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWHYOOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWHYOOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWHYOOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:14:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751443AbWHYOOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:14:32 -0400
Date: Fri, 25 Aug 2006 15:14:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] BLOCK: Remove dependence on existence of blockdev_superblock [try #2]
Message-ID: <20060825141411.GH10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213308.21323.20856.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213308.21323.20856.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:33:08PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Move blockdev_superblock extern declaration from fs/fs-writeback.c to a
> headerfile and remove the dependence on it by wrapping it in a macro.

Ok.

