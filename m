Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274133AbRJKJJh>; Thu, 11 Oct 2001 05:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRJKJJ1>; Thu, 11 Oct 2001 05:09:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:29660 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S274133AbRJKJJN>; Thu, 11 Oct 2001 05:09:13 -0400
Date: Thu, 11 Oct 2001 11:09:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: "attempt to access beyond end of device" in 2.4.10ac10
In-Reply-To: <Pine.NEB.4.40.0110102205470.16121-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.NEB.4.40.0110111105290.19298-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Adrian Bunk wrote:

>...
> > Did you try earlier kernels with success?
>
> I didn't have this problem before - and I use 2.4(-ac) kernels since
> 2.4.0-test times.
>
>...
> > Any idea what was happening at the time?
>
> No.

I must correct myself: I bootet a 2.4.7 instead and I had the same crash.
And there was one thing that I did that I didn't before the past months: I
did run "nice abcde" (abcde is a music -> OGG/MP3 program, that means both
cdparanoia and lame were running at the same time) plus one or more other
programs that cause high sytem load (this time it was an
"apt-get dist-upgrade").


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

