Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTENKQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTENKQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:16:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261835AbTENKQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:16:12 -0400
Date: Wed, 14 May 2003 12:28:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v3
Message-ID: <20030514102859.GJ17033@suse.de>
References: <20030514032712.0c7fa0d1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514032712.0c7fa0d1.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Andrew Morton wrote:
> 
> Quite a lot of changes here.  Mostly additions, but some things have been
> crossed off.
> 
> -- IDE tcq. Either kill it or fix it. Not a "big todo", as such.

ide tcq should be fixed now

-- 
Jens Axboe

