Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSHLDfA>; Sun, 11 Aug 2002 23:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318657AbSHLDfA>; Sun, 11 Aug 2002 23:35:00 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:23502 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318314AbSHLDe7>; Sun, 11 Aug 2002 23:34:59 -0400
Date: Mon, 12 Aug 2002 04:17:36 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rob Landley <landley@trommello.org>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Oliver Xymoron <oxymoron@waste.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: klibc development release
Message-ID: <20020812041736.A4016@kushida.apsleyroad.org>
References: <200208111820.g7BIKPd172856@saturn.cs.uml.edu> <200208112031.g7BKVHQ209420@pimout1-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208112031.g7BKVHQ209420@pimout1-ext.prodigy.net>; from landley@trommello.org on Sun, Aug 11, 2002 at 11:31:13AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> (Dietlibc is straight GPL: it can't even be the dynamic replacement
> for glibc in a real world linux distribution.  HPA suggested I look at
> newlibc, which I've added to my to-do list).

Since klibc is meant for compiling programs tightly bound to the kernel
in initramfs, such as partition scanning, NFS root mounting, module
loading etc., I wonder what the problem with even a GPLed klibc is?

Surely all the programs that its intended to be used with will be GPLed,
perhaps even part of the kernel source tree?

(Not that I mind at all.  I expect I will be using klibc's simplicity
and 3-clause BSD license in my employer's proprietary product soon enough..)

-- Jamie
