Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSFJTVh>; Mon, 10 Jun 2002 15:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSFJTVg>; Mon, 10 Jun 2002 15:21:36 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:51151
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315457AbSFJTVg>; Mon, 10 Jun 2002 15:21:36 -0400
Date: Mon, 10 Jun 2002 12:19:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020610191959.GJ14252@opus.bloom.county>
In-Reply-To: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com> <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 08:57:02PM +0200, Thomas 'Dent' Mirlacher wrote:
> On Mon, 10 Jun 2002, Maksim (Max) Krasnyanskiy wrote:
> 
> > Hi Martin,
> > 
> > How about replacing __FUNCTION__ with __func__ ?
> > GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.
> 
> is __func__ already supported for gcc 2.96?

Well it works with 2.95.3, which is the important part...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
