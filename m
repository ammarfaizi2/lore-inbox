Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267803AbUBRSiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUBRSiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:38:21 -0500
Received: from palrel13.hp.com ([156.153.255.238]:63966 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S267810AbUBRSiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:38:19 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.45326.877129.189633@napali.hpl.hp.com>
Date: Wed, 18 Feb 2004 10:38:06 -0800
To: Christoph Hellwig <hch@infradead.org>
Cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix update
In-Reply-To: <20040218170601.A10490@infradead.org>
References: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
	<20040218170601.A10490@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Feb 2004 17:06:01 +0000, Christoph Hellwig <hch@infradead.org> said:

  Christoph> The patch looks okay, but this whole fixup-based pci
  Christoph> initialization is just plain wrong to start with.

I don't think anybody is wedded to the code there.  From what I know,
it works fine, but if you want to submit enhancements, I'm pretty sure
they'd be appreciated.

	--david
