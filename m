Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUHHHrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUHHHrw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 03:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUHHHrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 03:47:52 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:46731 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265196AbUHHHru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 03:47:50 -0400
Date: Sun, 8 Aug 2004 09:47:47 +0200
From: David Weinehall <tao@debian.org>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040808074747.GK16937@khan.acc.umu.se>
Mail-Followup-To: Jan Knutar <jk-lkml@sci.fi>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de> <1091916508.19077.24.camel@localhost.localdomain> <yw1xu0ve1qqa.fsf@kth.se> <200408080533.40147.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408080533.40147.jk-lkml@sci.fi>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 05:33:39AM +0300, Jan Knutar wrote:
> On Sunday 08 August 2004 02:19, Måns Rullgård wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > 
> > > BTW while I remember cdrecord has a bug with hardcoded iso8859-1
> > > copyright symbols in it which mean your copyright banner is invalid
> > > unicode on a UTF-8 locale.
> > 
> > Does that also invalidate the copyright?
> > 
> 
> I was under the impression that printing copyright symbols isn't required.
> You have copyright on what you write unless you explicitly assign it away,
> which supposedly isn't even possible in some parts of the world, that is,
> you always retain copyright nomatter what.
> 
> <insert standard IANAL(IACOTW) disclaimer>

In *some* countries your copyright claim is strengthened by having
a "Copyright" and/or "©" clause.  Writing (C) has no legal effect
however, so you should always write out the full word, like so:

Copyright © 2004 Foo Bar, Baz Inc.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
