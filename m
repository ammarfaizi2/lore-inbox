Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVLPPsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVLPPsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLPPsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:48:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751298AbVLPPsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:48:15 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051216143110.GC1222@flint.arm.linux.org.uk> 
References: <20051216143110.GC1222@flint.arm.linux.org.uk>  <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com> <43A2BAA7.5000807@yahoo.com.au> <20051216132123.GB1222@flint.arm.linux.org.uk> <wn564ppnohn.fsf@linhd-2.ca.nortel.com> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linh Dang <linhd@nortel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 16 Dec 2005 15:46:41 +0000
Message-ID: <20058.1134748001@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Do you now see what I mean?  (yup, ARM is a llsc architecture.)

Out of interest, at what point did ARM become so? ARM6?

David
