Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTLLLIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 06:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTLLLIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 06:08:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5321 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264537AbTLLLIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 06:08:22 -0500
Date: Fri, 12 Dec 2003 12:08:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Vid Strpic <vms@bofhlet.net>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Backport ide-cd cdrecord support to 2.4
Message-ID: <20031212110810.GR7599@suse.de>
References: <20031212101748.GE11146@home.bofhlet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212101748.GE11146@home.bofhlet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12 2003, Vid Strpic wrote:
> On Thu, Dec 11, 2003 at 03:08:30PM -0800, Mike Fedyk wrote:
> > If there's one feature that I'd love to see in 2.4 it's eliminating my need
> > for ide-scsi completely. :)
> 
> Erm?  If fresh enough cdrtools, burning over atapi works in 2.4 too...
> I didn't say it's good, no, but it certainly works.

It's a bad solution though, even ide-scsi is faster than that :)

-- 
Jens Axboe

