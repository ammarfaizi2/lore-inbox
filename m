Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUHDPEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUHDPEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUHDPEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:04:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47513 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266242AbUHDPER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:04:17 -0400
Date: Wed, 4 Aug 2004 17:04:04 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040804150403.GU10340@suse.de>
References: <20040804085000.GH10340@suse.de> <20040804075215.155c06ac.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804075215.155c06ac.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2004, David S. Miller wrote:
> 
> When you pass data structures in via {read,write}{,v}() system calls,
> you make it next to impossible for the CONFIG_COMPAT layer to cope
> with this.
> 
> Please consider another way to pass in those sg_io_* things.

Any suggestions?

-- 
Jens Axboe

