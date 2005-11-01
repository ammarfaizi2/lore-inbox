Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVKACEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVKACEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 21:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVKACEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 21:04:13 -0500
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:17651 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S964938AbVKACEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 21:04:11 -0500
To: rolandd@cisco.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH/RFC] IB: Add SCSI RDMA Protocol (SRP) initiator
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <52wtjtk3d1.fsf@cisco.com>
References: <52wtjtk3d1.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051101110409V.fujita.tomonori@lab.ntt.co.jp>
Date: Tue, 01 Nov 2005 11:04:09 +0900
X-Dispatcher: imput version 20040704(IM147)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH/RFC] IB: Add SCSI RDMA Protocol (SRP) initiator
Date: Mon, 31 Oct 2005 09:23:06 -0800

> I've posted this several times for review and gotten some (but not
> very much) feedback.  Is there any objection to me asking Linus to
> pull this for 2.6.15?

Any reason the existing SRP definitions (drivers/scsi/ibmvscsi/srp.h)
doesn't work for you?
