Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbUK3SGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbUK3SGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbUK3R76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:59:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39088 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262222AbUK3RzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:55:22 -0500
Date: Tue, 30 Nov 2004 17:55:18 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130175518.GW26051@parcelfarce.linux.theplanet.co.uk>
References: <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <1101828924.26071.172.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> <1101832116.26071.236.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 08:53:34AM -0800, Linus Torvalds wrote:
> then I might listen. Notice how the only really constructive thing to come 
> out of this flame-fest has been a patch by Al that looked perfectly 
> reasonable, but that got totally drowned out by the arguing?

Frankly, I suspect that amount of effort that went into postings made in
that thread is approaching what it would take to clean the damn thing
up for good.  I wasn't kidding about 10 minutes work to do that patch...
