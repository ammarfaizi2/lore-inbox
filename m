Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282880AbRK0I7z>; Tue, 27 Nov 2001 03:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282879AbRK0I7p>; Tue, 27 Nov 2001 03:59:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:54756 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S282882AbRK0I7d>; Tue, 27 Nov 2001 03:59:33 -0500
Date: Tue, 27 Nov 2001 09:59:29 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <20011126203032.C26219@mikef-linux.matchmail.com>
Message-ID: <Pine.NEB.4.42.0111270957390.5290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Mike Fedyk wrote:

>...
> Let's hope $(test -z "`diff -u last-pre -final`") returns true for future
> 2.4 kernels.

This would mean that Marcelo has forgotten to change the version number in
the Makefile...  ;-)

> MF

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400


