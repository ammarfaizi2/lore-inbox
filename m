Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbTLIQlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbTLIQlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:41:18 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21993 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266036AbTLIQlR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:41:17 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bob <recbo@nishanet.com>
Subject: Re: merged in bk5 Re: Catching NForce2 lockup with NMI watchdog - found?
Date: Tue, 9 Dec 2003 17:43:09 +0100
User-Agent: KMail/1.5.4
References: <200312081321.06692.ross@datscreative.com.au> <3FD4B785.6010908@nishanet.com> <3FD5FBD5.1060400@nishanet.com>
In-Reply-To: <3FD5FBD5.1060400@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091743.09162.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 of December 2003 17:44, Bob wrote:
> if you're following this thread, good news--
>
> nforce2 fixups have been merged in

No.  This just a part of changelog for -bart1 patch.  :-)

> linux-2.6.0-test11-bk5.patch
> >  -bk snapshot (patch-2.6.0-test11-bk5)

I included latest snapshot cause my patch is for vanilla kernels.

> nforce2-disconnect-quirk.patch
>
> >  [x86] fix lockups with APIC support on nForce2
> >
> >nforce2-apic.patch
> >  [x86] do not wrongly override mp_ExtINT IRQ

--bart

