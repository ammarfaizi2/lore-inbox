Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVCBXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVCBXwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVCBXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:51:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45750 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261196AbVCBXpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:45:55 -0500
Message-ID: <42265023.20804@pobox.com>
Date: Wed, 02 Mar 2005 18:45:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk>
In-Reply-To: <20050302230634.A29815@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> This sounds good, until you realise that some of us have been sitting
> on about 30 patches for at least the last month, because we where
> following your guidelines about the -rc's.  Things like adding support
> for new ARM machines and other devices, dynamic tick support for ARM,
> etc.

30?  Try 310 changesets, in my netdev-2.6 pending queue.

	Jeff


