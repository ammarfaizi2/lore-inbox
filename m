Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWEaGPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWEaGPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWEaGPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:15:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45168 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964793AbWEaGPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:15:31 -0400
Date: Wed, 31 May 2006 08:17:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace_api.h: endian annotations
Message-ID: <20060531061736.GD29535@suse.de>
References: <20060530201817.GC7267@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530201817.GC7267@martell.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

It's fine I suppose, though it doesn't add much in the way of checking.
These are the ends of the chain, it's not structures we pass around.

-- 
Jens Axboe

