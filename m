Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTJJIYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTJJIYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:24:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12748 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262665AbTJJIYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:24:07 -0400
Date: Fri, 10 Oct 2003 10:23:51 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] [PATCH] generic HDLC Cisco bugfix
Message-ID: <20031010082351.GP1232@suse.de>
References: <m3ismyvz39.fsf@defiant.pm.waw.pl> <20031009234409.45300c62.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009234409.45300c62.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09 2003, David S. Miller wrote:
> I'd also not classify this patch as trivial, it's not like a missing
> semicolon or a comment typo, real thought needs to be applied to
> analyzing whether your fix were correct or not.

This seems to be a general problem with the trivial patchbot, people
mistake small for trivial.

-- 
Jens Axboe

