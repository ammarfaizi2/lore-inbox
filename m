Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312403AbSCYLkA>; Mon, 25 Mar 2002 06:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312404AbSCYLjv>; Mon, 25 Mar 2002 06:39:51 -0500
Received: from ns.suse.de ([213.95.15.193]:63241 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312403AbSCYLjn>;
	Mon, 25 Mar 2002 06:39:43 -0500
Date: Mon, 25 Mar 2002 12:39:42 +0100
From: Dave Jones <davej@suse.de>
To: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: David Flynn <dave@woaf.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: Possible problems with D-LINK DFE-550TX (stock sundance driver) under 2.4.18
Message-ID: <20020325123942.A23014@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	=?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	David Flynn <dave@woaf.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>
In-Reply-To: <200203250336.08428.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 03:36:07AM +0100, Dieter Nützel wrote:
 > > Try booting with just one processor (maxcpus=1 boot option) or borrow
 > > two Athlon MP and see if you can reproduce the problem then. If you can,
 > > someone may help you. I you can't reproduce it with one CPU, you're
 > > probably on your own.
 > 
 > On "newer" Athlon XP (Duron, Athlon Thoroughbred) L5-4 bridge have to be 
 > closed.

You don't for a minute think that there might be a reason that bridge
got broken at the factory ? *sigh*, we've been through this topic
before, I'm tired of arguing it. 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
