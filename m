Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSGBTQB>; Tue, 2 Jul 2002 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316885AbSGBTQA>; Tue, 2 Jul 2002 15:16:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316882AbSGBTP7> convert rfc822-to-8bit; Tue, 2 Jul 2002 15:15:59 -0400
Date: Tue, 2 Jul 2002 15:18:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Mohamed Ghouse Gurgaon <MohamedG@ggn.hcltech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Diff b/w 32bit & 64-bit
In-Reply-To: <yw1x1yamar52.fsf@gladiusit.e.kth.se>
Message-ID: <Pine.LNX.3.95.1020702151441.1918A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Jul 2002, [iso-8859-1] Måns Rullgård wrote:

> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
> 
> > =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= writes:
> > 
> > > For Alpha: sizeof(int) == 4, sizeof(long) == 8, sizeof(void *) == 8
> > > For intel: sizeof(int) == 4, sizeof(long) == 4, sizeof(void *) == 8
> > 
> > That second line is _only_ correct for Win64.
> 

"Win64"?? Do you mean that M$ now takes credit for SEGMENT:OFFSET?
Good! That'll keep 'em in their place!  Seriously, I think it's
really Win48 --another Windows distortion. Segment descriptor is
16 bits and the offset remains 32.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

