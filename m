Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVCYTY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVCYTY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVCYTY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:24:27 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:51366 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261751AbVCYTYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:24:22 -0500
Subject: Re: megaraid driver (proposed patch)
From: James Bottomley <jejb@steeleye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bruno Cornec <Bruno.Cornec@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, tvignaud@mandrakesoft.com
In-Reply-To: <20050325190732.GA15497@infradead.org>
References: <20050325182252.GA4268@morley.grenoble.hp.com>
	 <1111775992.5692.25.camel@mulgrave> <20050325184718.GA15215@infradead.org>
	 <1111777477.5692.29.camel@mulgrave>  <20050325190732.GA15497@infradead.org>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 13:24:17 -0600
Message-Id: <1111778657.5692.40.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 19:07 +0000, Christoph Hellwig wrote:
> The new megaraid driver doesn't support old hardware.  Maybe we should
> drop the overlapping pci ids from the old driver?

That works for me too ... but the people who get to decide what to do
should be the driver maintainers.

James


