Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUBJSz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUBJSz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:55:28 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:13075 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266308AbUBJSzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:55:24 -0500
Date: Tue, 10 Feb 2004 19:59:23 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
In-Reply-To: <20040210104250.11e95c87.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0402101955060.2349-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, David S. Miller wrote:

> Believe it or not your work still sits deep in my inbox waiting for my backlog
> to work on back to it.
> 
> I'll try to get to this again.

Ok, Thanks.

It's not particularly urgent but my concern was just the patch wouldn't 
apply any longer once colliding dma stuff gets in...
And the dma_pool stuff might be a good motivation for arch maintainers to 
adopt this in one go ;-)

Martin

