Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285472AbRLYL12>; Tue, 25 Dec 2001 06:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285465AbRLYL1S>; Tue, 25 Dec 2001 06:27:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:47825 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S285472AbRLYL1D>; Tue, 25 Dec 2001 06:27:03 -0500
Date: Tue, 25 Dec 2001 12:26:58 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Tony Hoyle <tmh@nothing-on.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: .text.exit compile error in 2.4.17
In-Reply-To: <3C2797F4.42DD94EE@nothing-on.tv>
Message-ID: <Pine.NEB.4.43.0112251224290.16722-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001, Tony Hoyle wrote:

>...
> You can downgrade to the binutils in debian stable, which although it is
> ancient, seems to work (the kernel it builds seems to be a bit flaky,
> though,
> so I went back to my working 2.4.16 just to be safe).

Thanks, for the suggested wrokarounds but I know about the underlying
problem - all I wanted to say with my mail was that there's a .text.exit
compile error that is still present in 2.4.17.

> Tony

Merry Christmas
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

