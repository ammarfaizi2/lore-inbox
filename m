Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUHISd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUHISd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUHISad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:30:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36532 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266849AbUHIS32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:29:28 -0400
Date: Mon, 9 Aug 2004 20:29:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Josh Radel <jraidman-linux@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: elevator abstraction, anticipatory I/O backported to 2.4?
Message-ID: <20040809182921.GA28302@suse.de>
References: <20040807000316.85612.qmail@web81706.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807000316.85612.qmail@web81706.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Josh Radel wrote:
> Are there any existing patches for a backport of the
> 2.6 elevator abstraction (or a specific patch for
> anticipatory I/O) to 2.4 kernels?

It would be hard to do. In fact it can't be done without hacking the
drivers to use it as well. So it might be doable just for fun, but not
as something maintainable.

-- 
Jens Axboe

