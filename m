Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269896AbRHECRs>; Sat, 4 Aug 2001 22:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269897AbRHECRi>; Sat, 4 Aug 2001 22:17:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:1806 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269896AbRHECRb>;
	Sat, 4 Aug 2001 22:17:31 -0400
Date: Sat, 4 Aug 2001 23:17:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
In-Reply-To: <20010805034312.A18996@weta.f00f.org>
Message-ID: <Pine.LNX.4.33L.0108042316430.2526-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2001, Chris Wedgwood wrote:

> Some time ago, the logic for merging VMAs was changing (simplified).
> I noticed a couple of applications, specifically things seemed a bit
> sluggish when running things that either grow slowly or use lots of
> shared libraries:
>
> cw:tty5@tapu(cw)$ wc -l /proc/1368/maps
>    5287 /proc/1368/maps

Ouch, what kind of application is this happening with ?

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

