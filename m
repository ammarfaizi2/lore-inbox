Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275091AbTHGF6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275105AbTHGF6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:58:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1174 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S275091AbTHGF6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:58:06 -0400
Date: Thu, 7 Aug 2003 07:57:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: cb-lkml@fish.zetnet.co.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disk priority dependend on nice level...
Message-ID: <20030807055754.GP7982@suse.de>
References: <20030806232810.GA1623@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806232810.GA1623@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07 2003, Pavel Machek wrote:
> Hi!
> 
> I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
> but it compiles ;-).

This wont do much, you might as well forget it. Disk priorities is far
more work than you appear to think :)

-- 
Jens Axboe

