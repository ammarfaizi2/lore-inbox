Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVLPPuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVLPPuB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVLPPuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:50:01 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45267 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750715AbVLPPt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:49:59 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Christopher Friesen" <cfriesen@nortel.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134556187.2894.7.camel@laptopd505.fenrus.org>
	<1134558188.25663.5.camel@localhost.localdomain>
	<1134558507.2894.22.camel@laptopd505.fenrus.org>
	<1134559470.25663.22.camel@localhost.localdomain>
	<20051214033536.05183668.akpm@osdl.org>
	<15412.1134561432@warthog.cambridge.redhat.com>
	<11202.1134730942@warthog.cambridge.redhat.com>
	<43A2BAA7.5000807@yahoo.com.au>
	<20051216132123.GB1222@flint.arm.linux.org.uk>
	<wn564ppnohn.fsf@linhd-2.ca.nortel.com>
	<20051216143110.GC1222@flint.arm.linux.org.uk>
From: "Linh Dang" <linhd@nortel.com>
Organization: Null
Date: Fri, 16 Dec 2005 10:49:03 -0500
In-Reply-To: <20051216143110.GC1222@flint.arm.linux.org.uk> (Russell King's
 message of "Fri, 16 Dec 2005 14:31:10 +0000")
Message-ID: <wn57ja5m49c.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> Do you now see what I mean?  (yup, ARM is a llsc architecture.)

Oh, I do see your point now! sorry for all the newbie noise!

-- 
Linh Dang
