Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313727AbSDUSl2>; Sun, 21 Apr 2002 14:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313725AbSDUSl1>; Sun, 21 Apr 2002 14:41:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47622 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313781AbSDUSlH>; Sun, 21 Apr 2002 14:41:07 -0400
Date: Sun, 21 Apr 2002 11:40:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Landley <landley@trommello.org>
cc: Alexander Viro <viro@math.psu.edu>, Ian Molton <spyro@armlinux.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <20020421081224.6B6C547B@merlin.webofficenow.com>
Message-ID: <Pine.LNX.4.44.0204211136590.17272-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Apr 2002, Rob Landley wrote:
>
> The well-defined resync points are the 2.5.N releases.  If -pre goes away,
> then the dot-releases might need to come a little closer together, that's all.

I agree.

I've told myself that I shouldn't have done "-preX" releases at all in
2.5.x - the "real" numbers have become diluted by them, and I suspect the
-pre's are really just because I got used to making them during the
over-long 2.4.x time.

For development stuff, I think I personally would rather have dailies
together with a higher frequency of "real" releases. But as it is now
(because it isn't automated), the dailies would be a lot of work..

		Linus

