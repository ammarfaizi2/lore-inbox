Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTLLHoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTLLHoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 02:44:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37268 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264500AbTLLHoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 02:44:24 -0500
Date: Fri, 12 Dec 2003 08:44:14 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Backport ide-cd cdrecord support to 2.4
Message-ID: <20031212074414.GO7599@suse.de>
References: <20031211230830.GJ15401@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211230830.GJ15401@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11 2003, Mike Fedyk wrote:
> If there's one feature that I'd love to see in 2.4 it's eliminating my need
> for ide-scsi completely. :)

Well that's not going to happen. It's not an isolated feature, it's a
small addon to the new block io infrastructure in 2.6.

-- 
Jens Axboe

