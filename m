Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSERQOA>; Sat, 18 May 2002 12:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSERQN7>; Sat, 18 May 2002 12:13:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61455 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313242AbSERQN7>; Sat, 18 May 2002 12:13:59 -0400
Date: Sat, 18 May 2002 09:14:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, <rusty@rustcorp.com.au>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <p733cwpzrp3.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0205180910570.26742-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18 May 2002, Andi Kleen wrote:
>
> Are you sure they even exist ?

Oh, like read() or write() for regular files? Yup, they exist.

		Linus

