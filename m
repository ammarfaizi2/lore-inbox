Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRK3UVm>; Fri, 30 Nov 2001 15:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281017AbRK3UVd>; Fri, 30 Nov 2001 15:21:33 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:44676 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S283776AbRK3UVS>; Fri, 30 Nov 2001 15:21:18 -0500
Message-ID: <3C07EA02.BE47260B@randomlogic.com>
Date: Fri, 30 Nov 2001 12:20:18 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <20011130185359.Q31176@blu> <3C07CDFB.7F1A9FFC@randomlogic.com> <20011130194711.S31176@blu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

antirez wrote:
> 
> On Fri, Nov 30, 2001 at 10:20:43AM -0800, Paul G. Allen wrote:
> > antirez wrote:
> > A variable/function name should ALWAYS be descriptive of the
> > variable/function purpose. If it takes a long name, so be it. At least
> > the next guy looking at it will know what it is for.
> 
> I agree, but descriptive != long
> 
> for (mydearcountr = 0; mydearcounter < n; mydearcounter++)
> 
> and it was just an example. Read it as "bad coding style".
> 

Well if you're counting dear in the kernel, I'd say you have more
problems than your coding style. ;)

PGA
-- 
Paul G. Allen
UNIX Admin II ('til Dec. 3)/FlUnKy At LaRgE (forever!)
Akamai Technologies, Inc.
www.akamai.com
