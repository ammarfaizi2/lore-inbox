Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWHXVlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWHXVlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWHXVlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:41:19 -0400
Received: from pat.uio.no ([129.240.10.4]:64703 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422677AbWHXVlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:41:16 -0400
Subject: Re: [PATCH 15/17] BLOCK: Stop CIFS from using EXT2 ioctl numbers
	directly [try #2]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060824213330.21323.88530.stgit@warthog.cambridge.redhat.com>
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
	 <20060824213330.21323.88530.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:41:09 -0400
Message-Id: <1156455669.5629.87.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.891, required 12,
	autolearn=disabled, AWL 0.60, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 22:33 +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Stop CIFS from using EXT2 ioctl numbers directly, making it use the ones in
> linux/fs.h instead.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  0 files changed, 0 insertions(+), 0 deletions(-)

Err... NACK?

   Trond

