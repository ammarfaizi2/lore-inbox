Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbTIKV4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTIKVxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:53:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56022 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261571AbTIKVwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:52:39 -0400
Date: Thu, 11 Sep 2003 23:52:38 +0200
From: Jens Axboe <axboe@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030911215238.GN12021@suse.de>
References: <20030910114346.025fdb59.akpm@osdl.org> <10720000.1063224243@flay> <20030911082057.GP1396@suse.de> <63090000.1063303982@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63090000.1063303982@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11 2003, Martin J. Bligh wrote:
> >> That's a real shame ... it seemed to work fine until recently. Some
> >> of the DVD writers (eg the one I have - Sony DRU500A or whatever)
> > 
> > Then maybe it would be a really good idea to find out why it doesn't
> > work with ide-cd. What are the symptoms?
> 
> Symptoms are that it required cdrecord-pro, which was a closed source
> piece of turd I can't do much with ;-)

Surely the pro version supports open-by-device as well? And then it
should work fine.

-- 
Jens Axboe

