Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291036AbSAaMUp>; Thu, 31 Jan 2002 07:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291039AbSAaMUf>; Thu, 31 Jan 2002 07:20:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47586 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291036AbSAaMUU>;
	Thu, 31 Jan 2002 07:20:20 -0500
Date: Thu, 31 Jan 2002 15:17:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C59353F.3080208@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0201311515350.9106-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jan 2002, Martin Dalecki wrote:

> And then we are still just discussing here how to get things IN. But
> there apparently currently is nearly no way to get things OUT of the
> kernel tree. Old obsolete drivers used by some computer since
> archeologists should be killed (Atari, Amiga, support, obsolete
> drivers and so on). Just let *them* maintains theyr separate kernel
> tree...

'old' architectures do not hinder development - they are separate, and
they have to update their stuff. (and i think the m68k port is used by
many other people and not CS archeologists.) Old drivers are not a true
problem either - if they dont compile that's the problem of the
maintainer. Occasionally old drivers get zapped (mainly when there is a
new replacement driver).

	Ingo

