Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUBRAJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUBRAJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:09:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63693 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266775AbUBRAIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:08:43 -0500
Date: Wed, 18 Feb 2004 00:08:42 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Alex Belits <abelits@phobos.illtel.denver.co.us>,
       Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
Message-ID: <20040218000842.GT8858@parcelfarce.linux.theplanet.co.uk>
References: <1077021379.6605.42.camel@ulysse.olympe.o2t> <Pine.LNX.4.58.0402171135180.10406@es1840.belits.com> <200402172256.30397.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402172256.30397.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 10:56:30PM +0100, Robin Rosenberg wrote:
> 
> Again users want characters, not bytes. Here up in the north we are among the
> lucky ones that can still read a partially unlegible file name, because enough many
> characters are usually just ascii. If a name was encoded in SJIS and you see them
> interpreted as UTF-8 you'll a a string of pure garbage and you need to ask a bit
> twiddler for help in decoding it simply becase ASCII characters are not likely to be
> among the characters.

What I see is a string of pure garbage _here_.  On l-k.  Large part of that
garbage obviously coming from kooks with agenda.  Could we please take that
shite to more appropriate place?  Alt.sex.encodings.byte.byte.byte, whatever.
