Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbTIPJ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTIPJ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:59:16 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:63694 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S261818AbTIPJ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:59:15 -0400
Message-ID: <3F66DD18.30405@cornell.edu>
Date: Tue, 16 Sep 2003 05:51:20 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jesper Juhl <jju@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config BLK_DEV_IDE_TCQ_DEPTH - text and real life don't
 match
References: <Pine.LNX.4.56.0309160025510.6467@jju_lnx.backbone.dif.dk> <20030916092730.GC930@suse.de>
In-Reply-To: <20030916092730.GC930@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So whatever happened to this list - are those things fixed now - has any
progress been made? I've had TCQ off for ages since it's dangerous for 
me. That and ACPI are the only things that don't work in 2.6 ...at least 
for me.

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/1655.html

Particulary, what happened to this one:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/1353.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/2296.html

Perhaps it's a reiser bug ... but I do remember corrupting an xfs after 
reiser, and I do remember it was 100% reproducible with depth 8 but not 
32 - at 32 on boot check passes.








