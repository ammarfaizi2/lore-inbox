Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUIDRsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUIDRsm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUIDRsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:48:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:52632 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264991AbUIDRqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:46:00 -0400
Subject: Re: [IA64] allow OEM written modules to make calls to ia64 OEM SAL
	functions.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dcn@sgi.com
In-Reply-To: <20040904103529.C13149@infradead.org>
References: <200409032207.i83M7CKj015068@hera.kernel.org>
	 <1094280707.2801.0.camel@laptop.fenrus.com>
	 <20040904103529.C13149@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094316214.10586.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 17:43:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-04 at 10:35, Christoph Hellwig wrote:
> > are there any such modules? Are they GPL licensed or all proprietary ?
> 
> SGI has stated they have propritary modules that need this, that's why it's
> got added despite my objections.

Wouldn't that be "had" since they are clearly now derivative works of
the GPL OS core.

