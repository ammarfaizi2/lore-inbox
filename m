Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWAJQjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWAJQjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWAJQjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:39:43 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:27285 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751136AbWAJQjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:39:43 -0500
Date: Tue, 10 Jan 2006 09:39:43 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@lst.de>
Cc: Kyle McMartin <kyle@parisc-linux.org>, akpm@osdl.org,
       carlos@parisc-linux.org, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] [PATCH 1/5] Add generic compat_siginfo_t
Message-ID: <20060110163943.GY19769@parisc-linux.org>
References: <20060108193755.GH3782@tachyon.int.mcmartin.ca> <20060109141355.GA22296@lst.de> <20060110150141.GE28306@quicksilver.road.mcmartin.ca> <20060110151547.GB17621@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110151547.GB17621@lst.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 04:15:47PM +0100, Christoph Hellwig wrote:
> Yes, the is_compat_task helper is a nice thing to have.  I haven't
> needed it for the signal bits I've done yet, but it's also useful
> elsewhere.  But IIRC someone vehemently opposed it in the last round
> of discussion.

Andi's now dropped his opposition, so I think we're fine.
