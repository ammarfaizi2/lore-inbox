Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTFFOUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTFFOUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:20:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49387 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261757AbTFFOUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:20:00 -0400
Date: Fri, 06 Jun 2003 07:31:03 -0700 (PDT)
Message-Id: <20030606.073103.123970371.davem@redhat.com>
To: willy@debian.org
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] ethtool_ops
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606142951.GB28581@parcelfarce.linux.theplanet.co.uk>
References: <20030606142951.GB28581@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Fri, 6 Jun 2003 15:29:51 +0100
   
   This patch introduces ethtool_ops and converts tg3 to use it.

I really like this.
