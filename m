Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVK0EXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVK0EXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 23:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVK0EXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 23:23:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750840AbVK0EXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 23:23:39 -0500
Date: Sat, 26 Nov 2005 20:23:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, ak@suse.de, tony.luck@intel.com
Subject: Re: [PATCH 0/3] move swiotlb.h header file to common code
Message-Id: <20051126202322.1931345a.akpm@osdl.org>
In-Reply-To: <20051124035544.GA5913@granada.merseine.nu>
References: <20051124035544.GA5913@granada.merseine.nu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> wrote:
>
> Unfortunatly applying any of the patches require the
>  other two.

Hence it all should be a single patch.  I made it thus.
