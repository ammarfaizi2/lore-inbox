Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267139AbUBMSPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267149AbUBMSPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:15:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24755 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267139AbUBMSPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:15:43 -0500
Date: Fri, 13 Feb 2004 18:15:42 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213181542.GD8858@parcelfarce.linux.theplanet.co.uk>
References: <1076604650.31270.20.camel@ulysse.olympe.o2t> <20040213030346.GF25499@mail.shareable.org> <1076695606.23795.23.camel@m222.net81-64-248.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076695606.23795.23.camel@m222.net81-64-248.noos.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 07:06:46PM +0100, Nicolas Mailhot wrote:
> And as for the filename problems :
> - just mangle existing invalid filenames when a default encoding is
> agreed upon
> - refuse to write new files with invalid filenames just like you would
> with the few names forbidden in ascii - apps will learn to cope.

What names forbidden in ASCII?
