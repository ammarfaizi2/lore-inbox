Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSDXCLV>; Tue, 23 Apr 2002 22:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSDXCLU>; Tue, 23 Apr 2002 22:11:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3592 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311147AbSDXCLT>; Tue, 23 Apr 2002 22:11:19 -0400
Date: Tue, 23 Apr 2002 19:10:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <ak@suse.de>, <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020424023249.B2756@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204231909250.10866-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Apr 2002, Andrea Arcangeli wrote:
>
>	  Basically they should only deal with the
> other operative systems now.

Yeah. And since the security hole is fairly small and insignificant in
comparison to some others, I suspect that the main "other operating
system" just won't care one way or the other.

		Linus

