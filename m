Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVCDBJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVCDBJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVCDBE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:04:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:11784 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262842AbVCDBCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:02:38 -0500
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][3/26] IB/mthca: improve CQ locking part 1
X-Message-Flag: Warning: May contain useful information
References: <2005331520.cHJfJcRbBu1fFgB6@topspin.com>
	<4227AD34.4050002@pobox.com> <20050304005824.GA18411@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Mar 2005 17:02:36 -0800
In-Reply-To: <20050304005824.GA18411@kroah.com> (Greg KH's message of "Thu,
 3 Mar 2005 16:58:24 -0800")
Message-ID: <527jkonryr.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 01:02:36.0418 (UTC) FILETIME=[DABEE620:01C52055]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Sure, I have no problem accepting that into the pci core.

What would pci_irq_sync() do exactly?

 - R.
