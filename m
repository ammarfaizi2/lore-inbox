Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266330AbUBQQq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266317AbUBQQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:46:58 -0500
Received: from mail.shareable.org ([81.29.64.88]:57988 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266328AbUBQQq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:46:57 -0500
Date: Tue, 17 Feb 2004 16:46:51 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217164651.GB23499@mail.shareable.org>
References: <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I think the filenames are just ways for a _program_ to look up stuff, and
> the human readability is a secondary thing (it's "polite", but not a
> fundamental part of their meaning).

Politeness is nice.  I'm sure there's a pragmatic reason most
filenames are meaningful text in some human language :)

I'd like a way to type something like "touch zöe.txt" on an ordinary
latin1 terminal and get a UTF-8 filename in my filesystem.  Thanks :)

-- Jamie
