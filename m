Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUH0R22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUH0R22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266727AbUH0R22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:28:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:31169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266721AbUH0R21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:28:27 -0400
Date: Fri, 27 Aug 2004 10:28:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Craig Milo Rogers <rogers@isi.edu>, linux-kernel@vger.kernel.org
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <20040827094346.B29407@infradead.org>
Message-ID: <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org>
 <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <20040827094346.B29407@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Christoph Hellwig wrote:
> 
> Umm, just because he's piised off we shouldn't removed support for hardware.
> it's not like the driver suddenly stops from working because it's unmaintained.

You didn't read what I wrote.

We don't remove drivers because the maintainers go away. There's tons of 
drivers that have no maintainer.

We remove drivers because the author _asks_ us to. If the person who wrote 
the code doesn't want the code in the kernel, that's a pretty big deal.

		Linus
