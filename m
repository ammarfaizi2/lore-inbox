Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311483AbSDUHv7>; Sun, 21 Apr 2002 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSDUHv6>; Sun, 21 Apr 2002 03:51:58 -0400
Received: from pc132.utati.net ([216.143.22.132]:54682 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S311483AbSDUHv6>; Sun, 21 Apr 2002 03:51:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Date: Sat, 20 Apr 2002 21:53:23 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020421081224.6B6C547B@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 April 2002 12:05 am, Alexander Viro wrote:

> FWIW, I doubt that dropping -pre completely in favour of dayly snapshots is
> a good idea - "2.5.N-preM oopses when ..." is preferable to "snapshot
> YY/MM/DD oopses when..." simply because it's easier to match bug reports
> that way. Having all deltas downloadable as diff+comment is wonderful, but
> it doesn't replace well-defined (and less frequent) resync points.

The well-defined resync points are the 2.5.N releases.  If -pre goes away, 
then the dot-releases might need to come a little closer together, that's all.

Rob
