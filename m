Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267908AbUBRT1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267909AbUBRT1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:27:35 -0500
Received: from palrel11.hp.com ([156.153.255.246]:57221 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S267906AbUBRT12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:27:28 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.48279.217876.842831@napali.hpl.hp.com>
Date: Wed, 18 Feb 2004 11:27:19 -0800
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
       davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix update
In-Reply-To: <20040218191559.B11957@infradead.org>
References: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
	<20040218170601.A10490@infradead.org>
	<16435.45326.877129.189633@napali.hpl.hp.com>
	<20040218184411.A11714@infradead.org>
	<16435.46665.488393.913044@napali.hpl.hp.com>
	<20040218191559.B11957@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Feb 2004 19:15:59 +0000, Christoph Hellwig <hch@infradead.org> said:

  Christoph> On Wed, Feb 18, 2004 at 11:00:25AM -0800, David Mosberger wrote:
  >> Where?  On linux-ia64 or on lkml?  I don't recall these discussions
  >> (but then again, I'm admittedly very good at forgetting stuff...).

  Christoph> Linux-IA64.  I sent a bunch of patches to you and Jesse
  Christoph> that you applied but large parts of SGI didn't for
  Christoph> certain reasons (NIH comes to mind).

Thankfully, I have no control over SGI's tree but if you have any
pending improvements for the generic ia64 portions, I'd certainly be
happy to take (another) look.  I really didn't (and still don't)
remember of there being anything pending in this area.  Not entirely
surprising though: I'm quite easy to satisfy as far as the PCI
subsystem goes (if it works, I'm happy ;-).

	--david
