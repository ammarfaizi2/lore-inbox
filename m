Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVKOAHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVKOAHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVKOAHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:07:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932201AbVKOAHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:07:23 -0500
Date: Mon, 14 Nov 2005 16:07:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve Dickson <SteveD@redhat.com>
Cc: torvalds@osdl.org, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FS-Cache: Make NFS use FS-Cache
Message-Id: <20051114160730.7d141291.akpm@osdl.org>
In-Reply-To: <43792217.7030102@RedHat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
	<43792217.7030102@RedHat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Dickson <SteveD@redhat.com> wrote:
>
> Here is a NFS patch that incorporates the FS-Cache hooks. The
> caching is done on a per filesystem bases using the new 
> -o fsc mount flag (i.e mount -o fsc server:/export /mnt/export)

OK, thanks.   What's the maturity of this patch?

Are you in a position to publish performance testing results?
