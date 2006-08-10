Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWHJUXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWHJUXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWHJUWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:22:42 -0400
Received: from mxsf29.cluster1.charter.net ([209.225.28.229]:32964 "EHLO
	mxsf29.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750969AbWHJUWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:22:34 -0400
X-IronPort-AV: i="4.08,112,1154923200"; 
   d="scan'208"; a="2047546568:sNHT2609248676"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17627.38258.546907.120948@stoffel.org>
Date: Thu, 10 Aug 2006 16:22:10 -0400
From: "John Stoffel" <john@stoffel.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       Erik Mouw <erik@harddisk-recovery.com>, Mingming Cao <cmm@us.ibm.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
In-Reply-To: <1155240524.12082.14.camel@kleikamp.austin.ibm.com>
References: <1155172642.3161.74.camel@localhost.localdomain>
	<20060810092021.GB11361@harddisk-recovery.com>
	<20060810175920.GC19238@thunk.org>
	<44DB8EBE.6060003@garzik.org>
	<1155240524.12082.14.camel@kleikamp.austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Kleikamp <shaggy@austin.ibm.com> writes:

Dave> IF it's decided to register the file system as ext3dev (Would
Dave> ext4dev make more sense?)

Hear hear!  I think ext4dev would be a better name too.  It's the
devel version of ext4, not ext3 after all...
