Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286442AbRLTWuK>; Thu, 20 Dec 2001 17:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286443AbRLTWuB>; Thu, 20 Dec 2001 17:50:01 -0500
Received: from mail.cafes.net ([207.65.182.25]:28432 "HELO mail.cafes.net")
	by vger.kernel.org with SMTP id <S286442AbRLTWtu>;
	Thu, 20 Dec 2001 17:49:50 -0500
Date: Thu, 20 Dec 2001 16:49:49 -0600
From: Mike Eldridge <diz@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011220164948.M23621@mail.cafes.net>
In-Reply-To: <20011220203223.GO7414@vega.digitel2002.hu> <Pine.LNX.3.95.1011220155155.8609A-100000@chaos.analogic.com> <20011220211422.GS7414@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011220211422.GS7414@vega.digitel2002.hu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 10:14:22PM +0100, Gábor Lénárt wrote:
> On Thu, Dec 20, 2001 at 04:05:26PM -0500, Richard B. Johnson wrote:
> > One of the many bad things about changing this kind of stuff is that
> > it doesn't even follow the rules, i.e., upper case is used for proper
> > names an/or where there could be a conflict between a previously-defined
> > abbreviation such as milliampere and megampere (mA, MA). Instead, most
> 
> OK, that's true, 'MA' is a nightmare even for the first sight ...
> 
> > everybody uses K for kilo and it's as absolutely incorrect as possible.
> > The existing symbols work by fiat. You can't make them "correct" by
> > following incorrect rules.
> 
> Oh well, sorry, so let's say about 'k' and 'm'. However an engineer friend
> of mine has just say that 'K' is 1024, and 'k' is 1000 ... I dunno anymore ...

i have seen kB instead of KB in many places.  and the only place i've
ever seen kilo abbreviated as K has been with respect to binary.

> [however I've never seen 'Kg' instead of 'kg', but 'mB' or 'mb' are ugly
> when compared with 'Mb' and 'MB', not counting that 'b' is bit and 'B' is
> byte ... well ... it's confusing sometimes ...]

i was going to comment about simply using lowercase equivalents, but
then milli already has 'm', although the concept of a millibyte (or even
millibit) is absurd.

-mike

--------------------------------------------------------------------------
   /~\  The ASCII                       all that is gold does not glitter
   \ /  Ribbon Campaign                 not all those who wander are lost
    X   Against HTML                          -- jrr tolkien
   / \  Email!

          radiusd+mysql: http://www.cafes.net/~diz/kiss-radiusd           
--------------------------------------------------------------------------
