Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVATIrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVATIrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVATIrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:47:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13963 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262075AbVATIrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:47:11 -0500
Date: Thu, 20 Jan 2005 09:46:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Dave Jones <davej@redhat.com>, chrisw@osdl.org,
       marcelo.tosatti@cyclades.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Lists-linux-kernel-news] Re: thoughts on kernel security issues
Message-ID: <20050120084659.GD12665@elte.hu>
References: <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu> <41EEA86D.7020108@comcast.net> <1106160943.6310.184.camel@laptopd505.fenrus.org> <41EEB920.8050609@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEB920.8050609@comcast.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Richard Moser <nigelenki@comcast.net> wrote:

> > Exec Shield does that too but only if your CPU has hardware assist for
> > NX (which all current AMD and most current intel cpus do).
> 
> Uh, ok.  You've read the code right?  *would rather hear from Ingo*

FYI, Arjan is one of the exec-shield developers. So he has not only read
the code but has written portions of it.

	Ingo
