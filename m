Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281692AbRLAVaw>; Sat, 1 Dec 2001 16:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281696AbRLAVan>; Sat, 1 Dec 2001 16:30:43 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:19334 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S281692AbRLAVad>; Sat, 1 Dec 2001 16:30:33 -0500
Message-ID: <3C094BAA.2A730D3B@randomlogic.com>
Date: Sat, 01 Dec 2001 13:29:14 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <3C07CCCD.EA5E340A@randomlogic.com> <3C07D669.6C234598@mandrakesoft.com> <3C07E6D3.89A648AB@randomlogic.com> <20011201185312.P5770@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> On Fri, Nov 30, 2001 at 12:06:43PM -0800, Paul G. Allen wrote:
> 
> [snip]
> > A person shouldn't _need_ a decent editor to pick out the beginning/end
> > of a code block (or anything else for that matter). The problem is
> > exacerbated when such a block contains other blocks and quickly picking
> > out where each begins/ends becomes tiresome. I _do_ have excellent
> > editors, IDEs, and source code browsers and have used many different
> > kinds in many different jobs. They still can not replace what the human
> > eye and mind perceive.
> 
> Uhhhm, knowing when a code block begins? Usually you'll notice this from
> the indentation. It's quite hard not to notice a tabsized shift
> to the right...
> 

Whitespace can be placed almost anywhere and the program will still
compile. It can even be removed altogether. The only thing that keeps a
program legible is proper formatting. It's real damn easy to miss a
brace when the formatting is poor. And real easy to spend an hour trying
to figure out where that missing brace goes, that is after the hour you
spent figuring out that it was missing in the first place.

I guess some people Just Don't Get It. Some people just do not know how
to write maintainable code.

PGA
-- 
Paul G. Allen
UNIX Admin II ('til Dec. 3)/FlUnKy At LaRgE (forever!)
Akamai Technologies, Inc.
www.akamai.com
