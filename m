Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbTBDRkp>; Tue, 4 Feb 2003 12:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbTBDRko>; Tue, 4 Feb 2003 12:40:44 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:43295 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S267300AbTBDRko>;
	Tue, 4 Feb 2003 12:40:44 -0500
Date: Tue, 4 Feb 2003 09:40:41 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030204094041.A25052@beaverton.ibm.com>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com> <200302040656.h146uJs10531@Port.imtp.ilyichevsk.odessa.ua> <162450000.1044342810@[10.10.2.4]> <20030204122536.GV6915@fs.tum.de> <173250000.1044373915@[10.10.2.4]> <177230000.1044376046@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <177230000.1044376046@[10.10.2.4]>; from mbligh@aracnet.com on Tue, Feb 04, 2003 at 08:27:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 08:27:28AM -0800, Martin J. Bligh wrote:
> >>> Comparing Intel's compiler vs GCC on Linux would be more interesting.
> >>> Anyone got a copy and some time to burn?
> >> 
> >> There are already people who have done this, e.g.
> >> 
> >>   http://www.coyotegulch.com/reviews/intel_comp/intel_gcc_bench2.html
> >> 
> >> compares g++ and Intel's C++ compiler with C++ code.
> > 
> > C would be infinitely more interesting ;-)
> 
> Speaking of which, has anyone ever compiled the ia32 Linux kernel with the
> Intel compiler? I thought I saw some patches floating around to make it
> compile the ia64 kernel .... that'd be an interesting test case ... might
> give us some ideas about what could be tweaked in GCC (or code rejiggled in
> the kernel).
> 
> M.

Martin -

Like this?

http://marc.theaimsgroup.com/?l=linux-kernel&m=103559880923586&w=2

-- Patrick Mansfield
