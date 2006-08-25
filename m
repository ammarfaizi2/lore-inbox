Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWHYQMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWHYQMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWHYQMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:12:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23759 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964826AbWHYQM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:12:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060825141311.GF10659@infradead.org> 
References: <20060825141311.GF10659@infradead.org>  <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213303.21323.78091.stgit@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] BLOCK: Don't call block_sync_page() from AFS [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 17:12:20 +0100
Message-ID: <9912.1156522340@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> commenting out thing using // isn't very nice.  Either remove it completely
> or use #if 0 with a normal /* */ that describes why it's not compiled.

It's something I'll look at when the new motherboard for my AFS server
arrives.  Till then, however...

David
