Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUBQUyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUBQUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:54:04 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13696 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266574AbUBQUxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:53:55 -0500
Date: Tue, 17 Feb 2004 20:53:08 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402172053.i1HKr80u000234@81-2-122-30.bradfords.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040217204758.GS8858@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de>
 <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org>
 <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org>
 <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <20040217204758.GS8858@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from viro@parcelfarce.linux.theplanet.co.uk:
> On Tue, Feb 17, 2004 at 08:35:22PM +0000, John Bradford wrote:
> > Why not:
> 
> [snip a massive pile of idiocy]
>  
> > * Note that this is very different to my last suggestion, which was
> >   fundamentally broken in many ways.
> 
> So is that one.  To the level of Hohensee and RBJ.

Correct me if I'm wrong, but your suggestions seems to be along the
lines of:

"Sit and watch a load of buggy userspace applications get written,
content in the knowledge that it wasn't my fault, because the security
vulnerabilities aren't actually in the kernel".

John.
