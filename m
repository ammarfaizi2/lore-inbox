Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUH2Tlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUH2Tlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUH2Tlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:41:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:60870 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268283AbUH2Tln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:41:43 -0400
Date: Sun, 29 Aug 2004 12:40:55 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040829194055.GA435@kroah.com>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org> <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <1093790181.27934.44.camel@localhost.localdomain> <Pine.LNX.4.58.0408291102010.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408291102010.2295@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 11:09:22AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 29 Aug 2004, Alan Cox wrote:
> > 
> > He is not sole author. Large parts of the code are based on other
> > authors work and simply copied from the standard framework. Please put
> > back the version without the hooks. It is useful to all sorts of people
> > in that form.
> 
> Are you willing to stand up for that and be the maintainer for it?

Someone has contacted me and Nemosoft and is willing to be the
maintainer, so it looks like this will happen.  That person is currently
working with Nemosoft to hash out a few issues and should soon be
sending a patch in to add the driver back, minus the hook.

At least that's what they say they will do :)

thanks,

greg k-h
