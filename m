Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUH0K2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUH0K2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUH0K2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:28:24 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:51210 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262574AbUH0K2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:28:22 -0400
Date: Fri, 27 Aug 2004 11:28:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       steved@redhat.com, dwmw2@redhat.com
Subject: Re: [PATCH] CacheFS - general filesystem cache
Message-ID: <20040827112813.A30219@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, steved@redhat.com,
	dwmw2@redhat.com
References: <17777.1093566183@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <17777.1093566183@redhat.com>; from dhowells@redhat.com on Fri, Aug 27, 2004 at 01:23:03AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 01:23:03AM +0100, David Howells wrote:
> 
> Hi Linus, Andrew,
> 
> I've packaged my generic filesystem cache filesystem into patches and also
> produced patches for my AFS filesystem to use it. Work is also in progress to
> alter the NFS client use this interface too, and I think the ISO9660
> filesystem could also benefit.
> 
> I've put a tarball of them on my Red Hat webpage because one of them is rather
> large. If you grab:
> 
> 	http://people.redhat.com/~dhowells/cachefs/cachefs-patches.tar.bz2

Umm, a tarball is the worst possible distribution method for patches.
Either inline them in the mail or if they are too large provide a direct
url to the patch.

