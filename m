Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbUK0FRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUK0FRd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUK0Dzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:55:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262509AbUKZTd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:27 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Alexandre Oliva <aoliva@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
In-Reply-To: <12983.1101470307@redhat.com>
References: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	 <19865.1101395592@redhat.com>
	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <12983.1101470307@redhat.com>
Content-Type: text/plain
Message-Id: <1101470443.8191.9438.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 26 Nov 2004 12:00:43 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-26 at 11:58 +0000, David Howells wrote:
> How about calling the interface headers "kapi*/" instead of "user*/". In case
> you haven't guessed, "kapi" would be short for "kernel-api".

I don't think that change really makes any difference. The nomenclature
really isn't _that_ important.

-- 
dwmw2

