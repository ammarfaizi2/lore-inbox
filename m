Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314494AbSEFPNf>; Mon, 6 May 2002 11:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314495AbSEFPNe>; Mon, 6 May 2002 11:13:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55047 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314494AbSEFPNe>; Mon, 6 May 2002 11:13:34 -0400
Date: Mon, 6 May 2002 08:13:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Pittman <daniel@rimspace.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Linux-2.5.14..
In-Reply-To: <87g015bxff.fsf@enki.rimspace.net>
Message-ID: <Pine.LNX.4.44.0205060811360.2540-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 May 2002, Daniel Pittman wrote:
>
> From the look of the changelog at least a few of the file corruption
> bugs with ext3, 2k block file systems and 2.5 have been fixed. Should I
> expect this release to address the problems I was seeing?

"Expect" is too strong a word. I'd say "hope" - a number of truncate bugs
were fixed, but whether that was what bit you, nobody knows.

I suspect the real answer is that we'd love for you to test things out,
but that if it ends up being too painful to recover if the problems happen
again, you probably shouldn't..

		Linus

