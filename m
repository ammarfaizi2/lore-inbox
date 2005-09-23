Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVIWSDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVIWSDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVIWSDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:03:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9044 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750934AbVIWSDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:03:44 -0400
Date: Fri, 23 Sep 2005 20:04:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: Block Device <blockdevice@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Trapping Block I/O
Message-ID: <20050923180407.GG22655@suse.de>
References: <64c7635405092305433356bd17@mail.gmail.com> <1e62d137050923103843058e92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e62d137050923103843058e92@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23 2005, Fawad Lateef wrote:
> you created wrapper .... So by doing this you can easily monitor
> requests (similar to this approach is used in LVM/RAID) ......

Or just use btrace, pull it from:

git://brick.kernel.dk/data/git/blktrace.git

-- 
Jens Axboe

