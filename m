Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311032AbSCMTIS>; Wed, 13 Mar 2002 14:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311029AbSCMTII>; Wed, 13 Mar 2002 14:08:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:36739 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311026AbSCMTIF>; Wed, 13 Mar 2002 14:08:05 -0500
Date: Wed, 13 Mar 2002 14:06:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: wli@holomorphy.com
cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020313021838.G14628@holomorphy.com>
Message-ID: <Pine.LNX.3.95.1020313134921.28928A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002 wli@holomorphy.com wrote:

[SNIPPED..]
You might want to look at www.eece.unm.edu/faculty/heileman/hash/hash.html
rather than assuming everyone is uninformed. Source-code is provided
for several hashing functions as well as source-code for tests. This
is a relatively old reference although it addresses both the chaos
and fractal methods discussed here, plus chaotic probe strategies
in address hashing.

A fast random number generator is essential to produce meaningful
tests within a reasonable period of time. It is also used within one
of the hashing functions to 'guess' at the direction of displacement
when an insertion slot is not immediately located, as well as the
displacement mechanism for several chaotic methods discussed.

Using your own hash-function as a template for tests of the same
hash-function, as you propose, is unlikely to provide meaningful
results.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

