Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTEEVYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTEEVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:24:54 -0400
Received: from palrel11.hp.com ([156.153.255.246]:13779 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261367AbTEEVYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:24:53 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16054.55698.719829.130251@napali.hpl.hp.com>
Date: Mon, 5 May 2003 14:37:22 -0700
To: Christoph Hellwig <hch@lst.de>
Cc: davidm@mostang.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] fixing the irqwcpustat mess
In-Reply-To: <20030505212546.A24006@lst.de>
References: <20030505212546.A24006@lst.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 5 May 2003 21:25:46 +0200, Christoph Hellwig <hch@lst.de> said:

  Christoph> What about this patch instead to make __ARCH_IRQ_STAT
  Christoph> useable?

Looks great to me.

Thanks,

	--david
