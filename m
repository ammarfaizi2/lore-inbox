Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276231AbRJKM0J>; Thu, 11 Oct 2001 08:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276135AbRJKM0A>; Thu, 11 Oct 2001 08:26:00 -0400
Received: from [213.45.102.230] ([213.45.102.230]:14346 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S276231AbRJKMZr>; Thu, 11 Oct 2001 08:25:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Tulip problem in Kernel 2.4.11
In-Reply-To: <000701c151c4$0e6933e0$0300a8c0@theburbs.com>
	<87u1x6zmdy.fsf@penny.ik5pvx.ampr.org> <m2adyy5ruh.fsf@euler.axel.nom>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 11 Oct 2001 14:26:13 +0200
In-Reply-To: <m2adyy5ruh.fsf@euler.axel.nom>
Message-ID: <87lmiimkgq.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Johan" == Johan Kullstam <kullstam@ne.mediaone.net> writes:


    > linux 2.4.11 is broken with respect to tulip driver and dec 21041
    > chipset.  my 21041 card doesn't work either.  what you can do is the
    > following.  compile kernel using a module for tulip driver.  go to
    > tulip.sourceforge.net.  get tulip-0.9.14.  unpack it.  for each new
    > kernel, manually (or make a script) compile a tulip driver in
    > tulip-0.9.14 and install it in
    > /lib/module/2.4.X/kernel/drivers/net/tulip.  this will replace the
    > broken driver and keep you going.

Ok, thanks for the suggestion. What I have now is a 2.4.12 kernel with
the 2.4.2 tulip module. Thanks fabbione for doing the hard work in my
place.

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.7 #1 Thu Jul 26 14:48:56 CEST 2001 i686 unknown
