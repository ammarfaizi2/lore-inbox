Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTIAPwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTIAPwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:52:06 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25728 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S262984AbTIAPvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:51:31 -0400
Date: Mon, 1 Sep 2003 08:51:30 -0700 (PDT)
From: Tigran Aivazian <tigran@veritas.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, <tigran@aivazian.fsnet.co.uk>
Subject: Re: dontdiff for 2.6.0-test4
In-Reply-To: <20030901163958.A24464@infradead.org>
Message-ID: <Pine.GSO.4.44.0309010848040.18476-100000@north.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Sep 01, 2003 at 07:57:27AM -0700, Tigran Aivazian wrote:
> > I have updated dontdiff in the usual place:
> >
> >   http://www.moses.uklinux.net/patches/dontdiff
> >
> > for the 2.6 kernels. Obviously this was only tested on my configuration(s)
> > so any additions are welcome. Just email them to me and I will add them.
> >
> > For those who don't know what "dontdiff" is --- grep the file:
> >
> > /usr/src/linux/Documentation/SubmittingPatches
>
> Btw, what about putting this somewhere in the kernel tree?

Probably a good idea, because I hesitated whether to call this
"dontdiff-2.6" and leave the existing dontdiff for 2.4 or just switch to
2.6 (assuming it is applicable to 2.4 as well). But if it is in the kernel
tree then no need to worry about which dontdiff matches which kernel.

Regards
Tigran

