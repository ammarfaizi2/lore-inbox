Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289012AbSBIQvg>; Sat, 9 Feb 2002 11:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289016AbSBIQv0>; Sat, 9 Feb 2002 11:51:26 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16777
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289012AbSBIQvQ>; Sat, 9 Feb 2002 11:51:16 -0500
Date: Sat, 9 Feb 2002 09:50:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>, David Lang <dlang@diginsite.com>,
        Larry McVoy <lm@bitmover.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020209165054.GK20094@opus.bloom.county>
In-Reply-To: <20020208211257.F25595@work.bitmover.com> <Pine.LNX.4.44.0202090212420.25220-100000@dlang.diginsite.com> <20020209075425.A13258@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209075425.A13258@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 07:54:25AM -0800, Larry McVoy wrote:
> On Sat, Feb 09, 2002 at 02:14:52AM -0800, David Lang wrote:
> > and if you keep doing this you will also need to cleanup and implement the
> > 'hardlink for identical files' idea that was batted around a year or so
> > ago, otherwise with all the copies of the linus tree with a few K of
> > patches from different developers you'll start to notice the storage space
> > used, even at today's drive prices :-)
> 
> bk clone -l

Erm:
$ bk version
BitKeeper/Free version is bk-2.1.4 20020205155016 for x86-glibc22-linux
Built by: lm@redhat71.bitmover.com in /build/bk-2.1.x-lm/src
Built on: Tue Feb  5 08:01:19 PST 2002
$ bk clone -l
usage:  bk clone [-ql] [-E<env>=<val>] [-r<rev>] [-z[<d>]] <from> [<to>]

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
