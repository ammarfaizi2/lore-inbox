Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265011AbRFUPke>; Thu, 21 Jun 2001 11:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbRFUPkY>; Thu, 21 Jun 2001 11:40:24 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:54286 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S265011AbRFUPkG>; Thu, 21 Jun 2001 11:40:06 -0400
Date: Thu, 21 Jun 2001 17:39:49 +0200
From: Kurt Roeckx <Q@ping.be>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
Message-ID: <20010621173949.D378@ping.be>
In-Reply-To: <200106082116.f58LGd2497562@saturn.cs.uml.edu> <B7471019.F9CF%bootc@worldnet.fr> <83JR8lhmw-B@khms.westfalen.de> <a05101002b75785e5b3fc@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <a05101002b75785e5b3fc@[192.168.239.105]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 12:18:12PM +0100, Jonathan Morton wrote:
> I've been taught by every Maths, Engineering and Physics 
> teacher/lecturer I've encountered to write down significant figures 
> consistent with the precision of the value.  So blindly writing down 
> a value of 59.42886726469 ±2°C is obviously ludicrous, even if that's 
> what my calculator gives me.  I should instead write 59 ±2°C, since 
> that is the most precision I can possibly know it to.  With some 
> advanced measuring techniques it *may* be acceptable to write 59.43 
> ±2°C *at most*, and then only if you really know why you need the 
> extra information.

What they teached me in school is about the same.  But the rule
for the precision was to use two signicifant(?) decimals.  So
you end up with 59.4 ± 2.0 °C or something.

Also note that you have to round up the precision, so it couldn't
have been 2.01, but could have been 1.01 the way you wrote it.


Kurt

