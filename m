Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWHJU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWHJU0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWHJUZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:25:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:13700 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932520AbWHJUZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:25:00 -0400
Message-ID: <44DB9613.1060609@garzik.org>
Date: Thu, 10 Aug 2006 16:24:51 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Theodore Tso <tytso@mit.edu>, Erik Mouw <erik@harddisk-recovery.com>,
       Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
References: <1155172642.3161.74.camel@localhost.localdomain>	 <20060810092021.GB11361@harddisk-recovery.com>	 <20060810175920.GC19238@thunk.org>  <44DB8EBE.6060003@garzik.org> <1155240524.12082.14.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1155240524.12082.14.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:
> IF it's decided to register the file system as ext3dev (Would ext4dev
> make more sense?), I would prefer the config options and code continues
> to simply use ext4.

Code, I strongly agree.

But config options are a dime a dozen.  They change all the time, even 
for the same driver.

	Jeff


