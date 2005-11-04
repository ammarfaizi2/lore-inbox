Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVKDWZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVKDWZg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVKDWZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:25:36 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:35596 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751076AbVKDWZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:25:35 -0500
Date: Fri, 4 Nov 2005 17:23:37 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Santiago Leon <santil@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, netdev <netdev@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ibmveth fix panic in initial replenish cycle
Message-ID: <20051104222329.GB31524@tuxdriver.com>
Mail-Followup-To: Santiago Leon <santil@us.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>, netdev <netdev@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>
References: <20051101175617.25145.73324.sendpatchset@ltcml8p7.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101175617.25145.73324.sendpatchset@ltcml8p7.rchland.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 02:15:09PM -0500, Santiago Leon wrote:
> This patch fixes a panic in the current tree caused by a race condition between the initial replenish cycle and the rx processing of the first packets trying to replenish the buffers.

Please restrain your line widths to less than 80 characters.  72 is
a nice number IMHO.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
