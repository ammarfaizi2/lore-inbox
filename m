Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbTGHTCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267525AbTGHTCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:02:05 -0400
Received: from ns.suse.de ([213.95.15.193]:20499 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267522AbTGHTCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:02:03 -0400
Date: Tue, 8 Jul 2003 21:16:39 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AES for CryptoAPI - i586-optimized
Message-Id: <20030708211639.0c7a8c8a.ak@suse.de>
In-Reply-To: <20030708172848.GA17115@gtf.org>
References: <20030708152755.GA24331@ghanima.endorphin.org.suse.lists.linux.kernel>
	<20030708174907.A18997@infradead.org.suse.lists.linux.kernel>
	<p737k6tq6x0.fsf@oldwotan.suse.de>
	<20030708172848.GA17115@gtf.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 13:28:48 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:


> I agree 100% with what you state here... but at the same time I was
> thinking it would be nice to merge, mainly as an example of asm support
> if nothing else.

There already is an example for optimized variants - the z990 implementation.

-Andi

