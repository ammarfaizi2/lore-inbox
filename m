Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312570AbSDOBaO>; Sun, 14 Apr 2002 21:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312573AbSDOBaN>; Sun, 14 Apr 2002 21:30:13 -0400
Received: from [212.57.170.37] ([212.57.170.37]:41993 "EHLO zzz.zzz")
	by vger.kernel.org with ESMTP id <S312570AbSDOBaN>;
	Sun, 14 Apr 2002 21:30:13 -0400
Date: Mon, 15 Apr 2002 07:25:56 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: Dave Jones <davej@suse.de>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: FIXED_486_STRING ?
Message-ID: <20020415072556.A2839@natasha.zzz.zzz>
In-Reply-To: <20020413224743.A13355@natasha.zzz.zzz> <32667.1018744038@ocs3.intra.ocs.com.au> <20020414024406.A16692@suse.de> <20020415063825.A2691@natasha.zzz.zzz> <20020415030355.D20383@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 03:03:55AM +0200, Dave Jones wrote:
> Petko Manolov <lz5mj@yahoo.com> did some work on them circa 2.4.0test.
> His patch is at http://www.dce.bg/~petkan/linux/string-486.diff
> Aparently there are still 1-2 problems with these routines which is
> why he hasn't pushed for inclusion I guess.
> 
These patches are included...  But the string-486.h itself is turned
off by FIXED_486_STRING.  BTW, what are the problems?
