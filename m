Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268290AbUHQP4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbUHQP4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268272AbUHQP4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:56:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37608 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268290AbUHQPwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:52:49 -0400
Subject: Re: Merge I2O patches from -mm
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Warren Togami <wtogami@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040817160621.A22892@infradead.org>
References: <411F37CC.3020909@redhat.com>
	 <20040817125303.A21238@infradead.org> <412208A6.7020104@shadowconnect.com>
	 <1092751257.22793.8.camel@localhost.localdomain>
	 <20040817160621.A22892@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092754208.22792.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 15:50:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-17 at 16:06, Christoph Hellwig wrote:
> Okay, then we'll have to rething the data structures a little more.
> I was under the impression the scsi busses were completely faked for
> the OS.

Nope. I can send you the i2o 1.5 docs if you would like but they are
fairly heavy reading, and a testimony to a neat hardware design and
concept destroyed by committee.


