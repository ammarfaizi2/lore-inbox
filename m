Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUGHQ2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUGHQ2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUGHQ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:28:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:39592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263790AbUGHQ2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:28:05 -0400
Date: Thu, 8 Jul 2004 09:27:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Timothy Miller <miller@techsource.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0407080926240.1764@ppc970.osdl.org>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <40ED71BC.2030609@techsource.com>
 <Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jul 2004, Linus Torvalds wrote:
> 
> The fact is, when somebody else picks up a mistake, that doesn't make it 
> any less of a mistake.

Whee. Five seconds after writing the above and sending it off, what do I 
see on CNN but:

	Another 'Police Academy' in works
	New film would be eighth in series

	LOS ANGELES, California (Hollywood Reporter) -- "Police Academy"
	is back.  After a decade's absence from the big screen, the cop
	comedy franchise is gearing up for an eighth installment.

I rest my case.

		Linus
