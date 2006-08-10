Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWHJU1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWHJU1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWHJU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:27:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:35460 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750953AbWHJU1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:27:33 -0400
Message-ID: <44DB96B1.6040304@garzik.org>
Date: Thu, 10 Aug 2006 16:27:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: Theodore Tso <tytso@mit.edu>, Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
References: <1155172642.3161.74.camel@localhost.localdomain> <20060810092021.GB11361@harddisk-recovery.com> <20060810175920.GC19238@thunk.org> <44DB8EBE.6060003@garzik.org> <20060810202307.GB12766@harddisk-recovery.com>
In-Reply-To: <20060810202307.GB12766@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> So what about "ext4dev"? That shows that the filesystem is not ext3 and
> experimental.

<shrug>  Whatever people prefer most.

The important point is that CONFIG_EXPERIMENTAL isn't enough.

	Jeff


