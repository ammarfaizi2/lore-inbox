Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267166AbUBMSdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUBMSdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:33:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46259 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267166AbUBMSbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:31:49 -0500
Date: Fri, 13 Feb 2004 18:31:48 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Valdis.Kletnieks@vt.edu
Cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213183148.GF8858@parcelfarce.linux.theplanet.co.uk>
References: <1076604650.31270.20.camel@ulysse.olympe.o2t> <20040213030346.GF25499@mail.shareable.org> <1076695606.23795.23.camel@m222.net81-64-248.noos.fr> <20040213181542.GD8858@parcelfarce.linux.theplanet.co.uk> <200402131824.i1DIOX6o023463@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402131824.i1DIOX6o023463@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 01:24:33PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 13 Feb 2004 18:15:42 GMT, viro@parcelfarce.linux.theplanet.co.uk said:
> 
> > What names forbidden in ASCII?
> 
> Anything with a / or a \0 in it. ;)

You try and pass something _without_ \0 in it to the kernel ;-)
