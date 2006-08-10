Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWHJVFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWHJVFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWHJVFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:05:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:58548 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932321AbWHJVFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:05:16 -0400
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Jeff Garzik <jeff@garzik.org>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Theodore Tso <tytso@mit.edu>,
       Erik Mouw <erik@harddisk-recovery.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <44DB9613.1060609@garzik.org>
References: <1155172642.3161.74.camel@localhost.localdomain>
	 <20060810092021.GB11361@harddisk-recovery.com>
	 <20060810175920.GC19238@thunk.org>  <44DB8EBE.6060003@garzik.org>
	 <1155240524.12082.14.camel@kleikamp.austin.ibm.com>
	 <44DB9613.1060609@garzik.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 10 Aug 2006 14:05:12 -0700
Message-Id: <1155243912.4505.1.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 16:24 -0400, Jeff Garzik wrote:
> Dave Kleikamp wrote:
> > IF it's decided to register the file system as ext3dev (Would ext4dev
> > make more sense?), I would prefer the config options and code continues
> > to simply use ext4.
> 
> Code, I strongly agree.
> 
Current code is all "ext4": functions names, variables, file names etc.
(except when register itself it called "ext3dev")


