Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272141AbRHXPhd>; Fri, 24 Aug 2001 11:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272157AbRHXPhW>; Fri, 24 Aug 2001 11:37:22 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:12685
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S272144AbRHXPhQ>; Fri, 24 Aug 2001 11:37:16 -0400
Date: Fri, 24 Aug 2001 08:37:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jes Sorensen <jes@sunsite.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010824083728.J14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15a1rW-000MM9-00@f10.mail.ru> <20010823143443.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3ofp5wr46.fsf@lxplus035.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3ofp5wr46.fsf@lxplus035.cern.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 02:59:37PM +0200, Jes Sorensen wrote:
> >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> 
> Tom> On Fri, Aug 24, 2001 at 01:18:02AM +0400, Samium Gromoff wrote:
> >> but imagine the X arch hacker does not like python, and
> >> nevertheless needs to port it on arch X.  still fun?
> 
> Tom> Well I know python is endian-clean.  I'd suspect it's even
> Tom> 32/64bit clean.  So it's not a matter of 'port' but compile.  And
> Tom> Linus has done things which have made lots of kernel hackers
> Tom> scratch their head for a while.  (Jump out of this fire and into
> Tom> the min/max macros in 2.4.9 fire to see what I mean).
> 
> Again, please try and do real porting work before you make such silly
> statements. Perl is 32/64 little/big-endian clean ... and still it's
> the absolutely worst app to bring up (even X tends to be easier).

perl is (or was last time I tried it) a PITA because it doesn't have
a real config script.  In my experiance (and I do have a lot here)
apps which use autoconf/et al suck less at porting, as long as you have
autoconf/libtool/et al happy.  Then it usually comes down to poorly
written code.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
