Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUBQUmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUBQUlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:41:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:5509 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266533AbUBQUke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:40:34 -0500
Date: Tue, 17 Feb 2004 20:40:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217204024.GE24311@mail.shareable.org>
References: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk> <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> However, I don't see why it is any more logical to make the suggestion
> that filenames generally be treated as UTF-8, IFF they are text at
> all, than it is to suggest that filename should be arbitrary strings
> of 32-bit words.

Ok, but... why?  What does 32-bit words get you that UTF-8 does not?
I can't think of a single advantage, just lots of disadvantages.

-- Jamie
