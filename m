Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUHJQim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUHJQim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUHJQgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:36:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32727 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267552AbUHJQZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:25:46 -0400
Date: Tue, 10 Aug 2004 18:25:11 +0200
From: Jens Axboe <axboe@suse.de>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cciss update [1/8] ioctl32 fix
Message-ID: <20040810162510.GB15091@suse.de>
References: <20040810160140.GA19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810160140.GA19909@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2004, mikem wrote:
> My latest updates are not in 2.6.8-rc4. So I am resubmitting them.

They are in -mm, it's customary for patches for misc drivers to go
through there and be fed to Linus by Andrew after a little while. So if
they are in -mm, you can consider them safely on their way to Linus.
I've never seen Andrew drop patches from -mm without first asking.

-- 
Jens Axboe

