Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTE3ULw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTE3ULw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:11:52 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:28804 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S263969AbTE3ULu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:11:50 -0400
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function
	declarations.
From: Steven Cole <elenstev@mesatop.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030530201429.GA3308@wohnheim.fh-wedel.de>
References: <1054324633.3754.119.camel@spc9.esa.lanl.gov>
	 <20030530201429.GA3308@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1054326307.3751.124.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 30 May 2003 14:25:07 -0600
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 14:14, Jörn Engel wrote:
> On Fri, 30 May 2003 13:57:13 -0600, Steven Cole wrote:
> > 
> > Maybe the following should be unnecessary after all these years since
> > the ANSI C standard was introduced, but several files associated with
> > zlib were using the old-style function declaration.
> > 
> > So, here is a proposed addition to CodingStyle, just to make it clear.
> 
> In the case of the zlib, just leave it as it is.  The less changes we
> make, to easier it is to merge upstream changes into the kernel.
> 
> Jörn

Whoops, sorry.  Linus started the old-style to new-style conversion in
zlib_inflate a few days ago, and I've sent Linus several patches
finishing the job in zlib_deflate and elsewhere.  Some are already in
the tree.

Steven

