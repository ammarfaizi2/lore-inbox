Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVIDQiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVIDQiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 12:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVIDQiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 12:38:22 -0400
Received: from ms-smtp-02-lbl.southeast.rr.com ([24.25.9.101]:26363 "EHLO
	ms-smtp-02-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S1750847AbVIDQiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 12:38:21 -0400
Message-Id: <200509041638.j84Gc5lA024062@ms-smtp-02-eri0.southeast.rr.com>
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Herbert Xu'" <herbert@gondor.apana.org.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Potential IPSec DoS/Kernel Panic with 2.6.13
Date: Sun, 4 Sep 2005 12:38:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <E1EBpnC-0001SQ-00@gondolin.me.apana.org.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcWxKk2vzf2inQanTWu/etX8RnVtQgARETPg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Herbert Xu
> Sent: Sunday, September 04, 2005 4:24 AM
> To: Matt LaPlante
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Potential IPSec DoS/Kernel Panic with 2.6.13
> 
> Matt LaPlante <laplam@rpi.edu> wrote:
> >
> > network connectivity on my router.  Upon further inspection I noticed
> the
> > packet had actually caused a kernel panic (visible only on the monitor,
> now
> > also unresponsive).
> 
> Thanks for the report.  I'll try to track it down.
> 
> If you could jot down the important bits of the panic message
> (IP, Call-Trace) it would help me find the problem much quicker.

I'd be more than happy to help you track this one down.  The problem here is
that the panic scrolls up and off the screen after which the system is
unusable.  Is there a way for me to capture it or redirect it somewhere that
I can read it?  I can also include my kernel config or any other system
details of interest.  Thanks.

-
Matt



