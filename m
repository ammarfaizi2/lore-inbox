Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbRFTVXs>; Wed, 20 Jun 2001 17:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbRFTVXi>; Wed, 20 Jun 2001 17:23:38 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:478 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S264630AbRFTVXY>;
	Wed, 20 Jun 2001 17:23:24 -0400
Date: Wed, 20 Jun 2001 23:23:22 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.20-pre4
In-Reply-To: <E15CS0l-0006co-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106202259290.21784-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Jun 2001, Alan Cox wrote:
> > Is it mean now kernel 2.2 with prepatch is (or will be) gcc 3.0 ready ?
> > If not what must be fixed/chenged to be ready ?
>
> It wont build with gcc 3.0 yet. To start with gcc 3.0 will assume it can
> insert calls to 'memcpy'

I tried it, but didn't run into problems (apart from the volatile
xtime thing)

Linux version 2.2.18 (eric@andredvb) (gcc version 3.0 (Debian))
#1 Wed Jun 20 23:15:46 CEST 2001

(Tons of warnings, though)

Eric

