Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVH3WVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVH3WVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVH3WVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:21:54 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:53774 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751102AbVH3WVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:21:53 -0400
Date: Tue, 30 Aug 2005 17:28:34 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH 4/9] UML - Mark SMP on UML/x86_64 as broken
Message-ID: <20050830212834.GA10579@ccure.user-mode-linux.org>
References: <200508292007.j7TK72Or029927@ccure.user-mode-linux.org> <p73vf1nqhqw.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vf1nqhqw.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:42:15PM +0200, Andi Kleen wrote:
> The generic one should work too, it's just less efficient.
> So you can probably easily replace them.

Yup, just something that hasn't been done yet.

				Jeff
