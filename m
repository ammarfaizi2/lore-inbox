Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUBWVeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUBWVbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:31:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:27619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262003AbUBWVb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:31:28 -0500
Date: Mon, 23 Feb 2004 13:36:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Herbert Poetzl <herbert@13thfloor.at>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
In-Reply-To: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Feb 2004, Rik van Riel wrote:
> On Sat, 21 Feb 2004, Linus Torvalds wrote:
> 
> > I'm really happy Intel finally got with the program,
> 
> With the program?  They still don't have an IOMMU ;)

Hmm.. Let's see what their chipsets will look like for this thing. Since
they don't have an integrated memory controller, they can't very well do
the IOMMU on the CPU, now can they?

So you can't blame them for that.

		Linus
