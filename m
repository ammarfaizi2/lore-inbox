Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVANWBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVANWBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVANV7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:59:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20996 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262164AbVANV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:57:35 -0500
Date: Fri, 14 Jan 2005 21:57:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050114215725.B5718@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
	marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>,
	chrisw@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>; from torvalds@osdl.org on Thu, Jan 13, 2005 at 09:19:16AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 09:19:16AM -0800, Linus Torvalds wrote:
> (Yes, Brad Spengler has talked to me about PaX, but never sent me 
> individual patches, for example. People seem to expect me to take all or 
> nothing

The same is true elsewhere as well, unfortunately.  I do wish people
would realise that there's a huge difference between "new feature"
patches and "small bugfix" patches.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
