Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266551AbUFZFFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266551AbUFZFFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 01:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUFZFFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 01:05:40 -0400
Received: from palrel12.hp.com ([156.153.255.237]:30394 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266551AbUFZFFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 01:05:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16605.1055.383447.805653@napali.hpl.hp.com>
Date: Fri, 25 Jun 2004 22:05:35 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit dma allocations on 64-bit platforms
In-Reply-To: <40D9D7BA.7020702@pobox.com>
References: <20040623183535.GV827@hygelac>
	<40D9D7BA.7020702@pobox.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 23 Jun 2004 15:19:22 -0400, Jeff Garzik <jgarzik@pobox.com> said:

  Jeff> swiotlb was a dumb idea when it hit ia64, and it's now been propagated
  Jeff> to x86-64 :(

If it's such a dumb idea, why not submit a better solution?

	--david
