Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273562AbRIUO3v>; Fri, 21 Sep 2001 10:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273561AbRIUO3m>; Fri, 21 Sep 2001 10:29:42 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:49587 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S273557AbRIUO3e>; Fri, 21 Sep 2001 10:29:34 -0400
Date: Fri, 21 Sep 2001 16:29:50 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010921162950.C16173@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <m1iteegag6.fsf@frodo.biederman.org> <Pine.LNX.4.33L.0109192000050.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33L.0109192000050.19147-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.22i
X-Operating-System: vega Linux 2.4.9 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:00:44PM -0300, Rik van Riel wrote:
> On 19 Sep 2001, Eric W. Biederman wrote:
> 
> > That added to the fact that last time someone ran the numbers linux
> > was considerably faster than the BSD for mm type operations when not
> > swapping.  And this is the common case.
> 
> Optimising the VM for not swapping sounds kind of like
> optimising your system for doing empty fork()/exec()/exit()
> loops ;)

Maybe not since I'm not using swap :) The rule is (well at least it was ...)
for 2.4.x desktop systems: buy 256Mb of RAM (and disable swapping at all),
it's cheap ... and after that you will be able to use 2.4.x instead of 2.2.x
quite well.

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
