Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUHHJRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUHHJRb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 05:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUHHJRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 05:17:31 -0400
Received: from mail.broadpark.no ([217.13.4.2]:21892 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265226AbUHHJR3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 05:17:29 -0400
To: Jan Knutar <jk-lkml@sci.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
	<1091916508.19077.24.camel@localhost.localdomain>
	<yw1xu0ve1qqa.fsf@kth.se> <200408080533.40147.jk-lkml@sci.fi>
	<20040808074747.GK16937@khan.acc.umu.se>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Sun, 08 Aug 2004 11:17:28 +0200
In-Reply-To: <20040808074747.GK16937@khan.acc.umu.se> (David Weinehall's
 message of "Sun, 8 Aug 2004 09:47:47 +0200")
Message-ID: <yw1xllgq0z13.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@debian.org> writes:

> On Sun, Aug 08, 2004 at 05:33:39AM +0300, Jan Knutar wrote:
>> On Sunday 08 August 2004 02:19, Måns Rullgård wrote:
>> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> > 
>> > > BTW while I remember cdrecord has a bug with hardcoded iso8859-1
>> > > copyright symbols in it which mean your copyright banner is invalid
>> > > unicode on a UTF-8 locale.
>> > 
>> > Does that also invalidate the copyright?
>> > 
>> 
>> I was under the impression that printing copyright symbols isn't required.
>> You have copyright on what you write unless you explicitly assign it away,
>> which supposedly isn't even possible in some parts of the world, that is,
>> you always retain copyright nomatter what.
>> 
>> <insert standard IANAL(IACOTW) disclaimer>
>
> In *some* countries your copyright claim is strengthened by having
> a "Copyright" and/or "©" clause.  Writing (C) has no legal effect
> however, so you should always write out the full word, like so:
>
> Copyright © 2004 Foo Bar, Baz Inc.

Seems like I didn't make the joke clear enough, though with legalities
you can never be too careful.

-- 
Måns Rullgård
mru@kth.se
