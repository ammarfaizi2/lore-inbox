Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265790AbRFXXQV>; Sun, 24 Jun 2001 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265788AbRFXXQL>; Sun, 24 Jun 2001 19:16:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34314 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265790AbRFXXQG>; Sun, 24 Jun 2001 19:16:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>,
        <linux-kernel@vger.kernel.org>
Subject: Re: GCC3.0 Produce REALLY slower code!
Date: Mon, 25 Jun 2001 01:19:06 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <001301c0fcff$47c05160$d55355c2@microsoft>
In-Reply-To: <001301c0fcff$47c05160$d55355c2@microsoft>
MIME-Version: 1.0
Message-Id: <0106250119060G.00430@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 00:44, Alexander V. Bilichenko wrote:
> Hello All!
> Some tests that I have recently check out.
> kernel compiled with 3.0 (2.4.5) function call: 1000000 iteration. 3%
> slower than 2.95.
> test example - hash table add/remove - 4% slower (compiled both
> with -O2 -march=i686).
> Why have this version been released?
> Best regards,
> Alexander         mailto:dmor@7ka.mipt.ru

Err, thanks for the benchmarks, but how does this qualify as 'really' slower?

Disassemblies of the inner loops would be very informative.

--
Daniel
