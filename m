Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUDVL7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUDVL7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUDVL7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:59:33 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:58599 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S263975AbUDVL7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:59:32 -0400
Date: Thu, 22 Apr 2004 13:59:27 +0200 (MET DST)
Message-Id: <200404221159.i3MBxRj25484@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
In-reply-to: <20040422124503.A20320@infradead.org> (message from Christoph
	Hellwig on Thu, 22 Apr 2004 12:45:03 +0100)
Subject: Re: [PATCH] fmount system call
References: <200404221054.i3MAsOJ06500@kempelen.iit.bme.hu> <20040422124503.A20320@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While I like the idea of fmount I think we should use the chance to untangle
> the mess the other mount paramters are.

OK.  Do you have a suggestion for a better interface?

Thanks,
Miklos
