Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbTBEUDs>; Wed, 5 Feb 2003 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBEUC3>; Wed, 5 Feb 2003 15:02:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27140 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264756AbTBEUCK> convert rfc822-to-8bit; Wed, 5 Feb 2003 15:02:10 -0500
Date: Wed, 5 Feb 2003 12:07:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel =?iso-8859-2?q?Jan=EDk?= <Pavel@Janik.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
In-Reply-To: <m3k7gfjb6f.fsf@Janik.cz>
Message-ID: <Pine.LNX.4.44.0302051157580.2999-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h15KBXF02896
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Feb 2003, Pavel [iso-8859-2] Janík wrote:
> 
> Hi Linus,
> 
>    > lcc isn't really something I want to use, since the license is so
>    > strange, and thus can't be improved upon if there are issues with it.
> 
> what is the difference between compiler and source management system
> regarding licenses and improvements?

You snipped the part where I said that the intel compiler is likely to be 
more interesting to a number of people, since it's at a higher level. So 
no, I'm not religious about licenses.

But the real issue is "does it do what we want it to do?" and "do we have
a choice?". There are no open-source SCM's that work for me. But there
_is_ an open-source compiler that does work for me. At which point the
license matters - simply because there is choice in the matter.

Gcc mostly works. But it's slower then I'd like. And it prioritizes things
I don't care about. And competition is always good. So I would definitely 
love to see some alternatives.

And if you have issues with BK, maybe you can try to encourage the SCM
people to see why I consider BK to not even have alternatives right now. 

		Linus

