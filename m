Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273018AbTHFM6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274997AbTHFM6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:58:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59316 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S273018AbTHFM6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:58:09 -0400
Date: Wed, 6 Aug 2003 14:58:07 +0200
From: Jens Axboe <axboe@suse.de>
To: lode leroy <lode_leroy@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: freeze while write()ing to /dev/hda1
Message-ID: <20030806125807.GB7982@suse.de>
References: <Sea2-F533UKyM25IFKq000424fa@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sea2-F533UKyM25IFKq000424fa@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06 2003, lode leroy wrote:
> oops... forgot to mention my system details in my previous mail:
> 
> i686, 64MB ram, 10GB harddisk

More interesting would be whether it hangs 2.6.0-test2 as well? Dunno
why you are reporting a bug against such an old kernel, if you want
people to take a look at it then reproduce with 2.6.0-test2.

-- 
Jens Axboe

