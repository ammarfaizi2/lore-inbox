Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277396AbRJJUJz>; Wed, 10 Oct 2001 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277394AbRJJUJq>; Wed, 10 Oct 2001 16:09:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:52706 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S277397AbRJJUJ2>; Wed, 10 Oct 2001 16:09:28 -0400
Date: Wed, 10 Oct 2001 22:09:52 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: "attempt to access beyond end of device" in 2.4.10ac10
In-Reply-To: <20011010125939.A524@mikef-linux.matchmail.com>
Message-ID: <Pine.NEB.4.40.0110102205470.16121-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Mike Fedyk wrote:

> > I had a crash with 2.4.10-ac10 (the computer was totally frozen - I had to
> > push the reset button). I found the following in syslog:
> >
> >
> > Oct 10 19:03:05 r063144 kernel: attempt to access beyond end of device
> > Oct 10 19:03:05 r063144 kernel: 03:06: rw=0, want=2147449990, limit=1959898
>
> Did you try earlier kernels with success?

I didn't have this problem before - and I use 2.4(-ac) kernels since
2.4.0-test times.

> Are your partitions setup correctly?

Yes.

> Which file system(s) was/were on this drive?

Several ext2 partitions are on the drive.

> Any idea what was happening at the time?

No.

> Mike

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

