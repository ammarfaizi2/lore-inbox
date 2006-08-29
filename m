Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWH2S2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWH2S2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWH2S2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:28:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30600 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964986AbWH2S2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:28:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829175421.GS12257@kernel.dk> 
References: <20060829175421.GS12257@kernel.dk>  <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com> 
To: Jens Axboe <axboe@kernel.dk>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] BLOCK: Permit block layer to be disabled [try #5] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 19:28:28 +0100
Message-ID: <750.1156876108@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> Any remaining changes? Looks fine to me, although I wonder why you did
> not kill the block_sync_page() completely in AFS. Christophs analysis
> looked correct to me.

Try #6 which I've just posted should do the trick.

David
