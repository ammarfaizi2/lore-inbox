Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbULNUdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbULNUdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbULNUdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:33:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:23703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbULNUdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:33:51 -0500
Date: Tue, 14 Dec 2004 12:33:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: Sam Ravnborg <sam@ravnborg.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Werner Almesberger <wa@almesberger.net>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <jer7lsocdx.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0412141232480.3279@ppc970.osdl.org>
References: <20041214135029.A1271@almesberger.net>
 <200412141923.iBEJNCY9011317@laptop11.inf.utfsm.cl> <20041214194531.GB13811@mars.ravnborg.org>
 <Pine.LNX.4.58.0412141150460.3279@ppc970.osdl.org> <jer7lsocdx.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Andreas Schwab wrote:
> 
> ??? We still do that, see NOSTDINC_FLAGS.

Ahh, yup, there is it. Goodie, I was just confused.

		Linus
