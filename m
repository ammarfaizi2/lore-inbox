Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287938AbSABTzU>; Wed, 2 Jan 2002 14:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287936AbSABTzK>; Wed, 2 Jan 2002 14:55:10 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:19468 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S287931AbSABTzF>; Wed, 2 Jan 2002 14:55:05 -0500
Date: Wed, 2 Jan 2002 11:52:44 -0800
To: David Weinehall <tao@acc.umu.se>
Cc: Stevie O <stevie@qrpff.net>, "David S. Miller" <davem@redhat.com>,
        Mika.Liljeberg@welho.com, kuznet@ms2.inr.ac.ru,
        Mika.Liljeberg@nokia.com, linux-kernel@vger.kernel.org,
        sarolaht@cs.helsinki.fi
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Message-ID: <20020102195244.GB10437@bluemug.com>
Mail-Followup-To: David Weinehall <tao@acc.umu.se>,
	Stevie O <stevie@qrpff.net>, "David S. Miller" <davem@redhat.com>,
	Mika.Liljeberg@welho.com, kuznet@ms2.inr.ac.ru,
	Mika.Liljeberg@nokia.com, linux-kernel@vger.kernel.org,
	sarolaht@cs.helsinki.fi
In-Reply-To: <3C1FA558.E889A00D@welho.com> <200112181837.VAA10394@ms2.inr.ac.ru> <3C1FA558.E889A00D@welho.com> <20011218.122813.63057831.davem@redhat.com> <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net> <20011220112218.X5235@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220112218.X5235@khan.acc.umu.se>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 11:22:18AM +0100, David Weinehall wrote:
> 
> Last time I checked, the ARM7tdmi was a mmu-less cpu -> ucLinux.

The Cirrus Logic EP7211, among others, is an ARM7TDMI with an MMU.

miket
