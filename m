Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290264AbSAXUzV>; Thu, 24 Jan 2002 15:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290290AbSAXUzL>; Thu, 24 Jan 2002 15:55:11 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:42664 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290289AbSAXUzA>; Thu, 24 Jan 2002 15:55:00 -0500
Date: Thu, 24 Jan 2002 21:54:56 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Ed Sweetman <ed.sweetman@wmich.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020124123548.91B4F65F@shrek.lisa.de>
Message-ID: <Pine.LNX.4.40.0201242152370.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Hans-Peter Jansen wrote:

> You can see, enough idleness...
>
> The question is, why amd_disconnect=true causes this distortion. I tend to
> believe that dis-/reconnecting CPU takes simply too long in this scenario.

hmmm ... yes ... this would be my idea too ... maybee the dis-reconnect
procedure is to slow on "slow" computers to grant undisrupted audio or
video streams ...

i have no problem with this ... maybee caus i have a "faster" cpu ?

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

