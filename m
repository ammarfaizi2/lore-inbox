Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUJYGDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUJYGDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUJYGDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:03:10 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:63718 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261505AbUJYGDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:03:07 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: generic hardirq code in 2.6.10-rc1
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	<20041024155443.GA25013@infradead.org>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 25 Oct 2004 15:02:59 +0900
In-Reply-To: <20041024155443.GA25013@infradead.org> (Christoph Hellwig's
 message of "Sun, 24 Oct 2004 16:54:43 +0100")
Message-ID: <buod5z7jpws.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> Btw, it would be nice if all architectures that have more or less
> a copy of the i386 irq.c could switch to the generic code.
>
> That would be:  alpha,ia64, m32r, mips, sh, sh64, um, v850

Er, yeah, hold on (speaking for v850, I generally only ever look at real
releases and try to update for the next one).

-Miles
-- 
`...the Soviet Union was sliding in to an economic collapse so comprehensive
 that in the end its factories produced not goods but bads: finished products
 less valuable than the raw materials they were made from.'  [The Economist]
