Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUBPPs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUBPPs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:48:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44995 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265763AbUBPPsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:48:55 -0500
Date: Mon, 16 Feb 2004 15:48:52 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Bradford <john@grabjohn.com>
Cc: Valdis.Kletnieks@vt.edu, Eduard Bloch <edi@gmx.de>,
       Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216154851.GM8858@parcelfarce.linux.theplanet.co.uk>
References: <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de> <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu> <200402161546.i1GFkLqx000741@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402161546.i1GFkLqx000741@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 03:46:21PM +0000, John Bradford wrote:
> The current situation is that so many applications simply treat
> filenames as arbitrary sequences of bytes.  With many encodings, this
> simply happens to work, and an encoding mis-match will result in some
> incorrect characters being displayed for byte values > 127.  However,
> some encodings, such as UTF-8, are simply _not_ compatible with the
> 'you can also treat it like an arbitrary byte string model', and there

Excuse me?  Would you fscking mind explaining what, in your opinion,
UTF-8 is and what makes "simply _not_ compatible" with aforementioned
model?
