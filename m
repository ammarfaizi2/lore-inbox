Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVEPCMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVEPCMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 22:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVEPCMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 22:12:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34969 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261242AbVEPCMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 22:12:00 -0400
Message-ID: <4288016A.1020202@pobox.com>
Date: Sun, 15 May 2005 22:11:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
References: <1115963481.1723.3.camel@alderaan.trey.hu> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <200505152156.18194.gene.heskett@verizon.net>
In-Reply-To: <200505152156.18194.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> I don't think I have any drives here that do obey that, Jeff.  I got 
> curious about this, oh, maybe a year back when this discussion first 
> took place on another list, and wrote a test gizmo that copied a 
> large file, then slept for 1 second and issued a sync command.  No 
> drive led activity until the usual 5 second delay of the filesystem 
> had expired.  To me, that indicated that the sync command was being 
> returned as completed without error and I had my shell prompt back 
> long before the drives leds came on.  Admittedly that may not be a 
> 100% valid test, but I really did expect to see the leds come on as 
> the sync command was executed.

> Again, probably not a valid test of the sync command, but thats the 
> evidence I have.  I do not believe it works here, with any of the 5 
> drives currently spinning in these two boxes.

Correct, that's a pretty poor test.

	Jeff


