Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWHYOJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWHYOJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWHYOJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:09:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:165 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751051AbWHYOJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:09:11 -0400
Date: Fri, 25 Aug 2006 15:08:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] BLOCK: Remove duplicate declaration of exit_io_context() [try #2]
Message-ID: <20060825140852.GC10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213255.21323.97639.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213255.21323.97639.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:32:56PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Remove the duplicate declaration of exit_io_context() from linux/sched.h.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

Ok.

