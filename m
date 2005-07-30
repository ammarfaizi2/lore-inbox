Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbVG3TzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbVG3TzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVG3TzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:55:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22419
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263125AbVG3Txs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:53:48 -0400
Date: Sat, 30 Jul 2005 12:53:54 -0700 (PDT)
Message-Id: <20050730.125354.112595635.davem@davemloft.net>
To: hch@lst.de
Cc: itn780@yahoo.com, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance
 Initiator
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050730183803.GA12081@lst.de>
References: <1122744762.5055.10.camel@mulgrave>
	<42EBC8A6.7030403@yahoo.com>
	<20050730183803.GA12081@lst.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator
Date: Sat, 30 Jul 2005 20:38:03 +0200

> On Sat, Jul 30, 2005 at 11:36:22AM -0700, Alex Aizman wrote:
> > OK. Hopefully that'll remain.
> 
> Please ask davem for a netlink number allocation.

There are none to allocate, see my other email as to how we
have to start handling the issue of many new netlink users
and the fact that we are out of numbers to give to people.
