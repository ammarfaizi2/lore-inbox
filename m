Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSGUAGD>; Sat, 20 Jul 2002 20:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGUAGD>; Sat, 20 Jul 2002 20:06:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317591AbSGUAGC>; Sat, 20 Jul 2002 20:06:02 -0400
Date: Sat, 20 Jul 2002 17:09:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, <akpm@zip.com.au>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VM strict overcommit
In-Reply-To: <1027213549.16819.70.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207201700360.2042-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Jul 2002, Alan Cox wrote:
>
> Thats fine be me too. I just grabbed the usual boilerplate but see
> COPYING is just fine

Good. I hate the fact that so many people seem to think that adding 15
lines of copyright notice to a file somehow makes it "more legal". All it
does is to give some corporate lawyer a bone, and take up precious
real-estate on the first thing you see when you open the file that could
be used to actually say what the file does (and who has worked on it).

Slightly off-topic, but in the same vein: I also dislike having tons of
changelogs that relate to matters that aren't relevant to the sources any
more (because the changes _changed_ them, duh!). The changelogs are valid
as a way to show who worked on what, of course, but some people seem to
take them to be the beginning of their Great Novel.

I'm hoping that one of the things BK does is to make people less inclined
to write change stories in the C files, and more inclined to explain them
to me in email when they send the changes in. At which point they are
there in a format where you can actually see the "before and after"
picture, not just get a feeling that "it looked different before" - well,
DUH!

			Linus

