Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVJIJaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVJIJaH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 05:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVJIJaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 05:30:07 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:53422 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1751151AbVJIJaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 05:30:06 -0400
Date: Sun, 9 Oct 2005 06:30:00 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051009093000.GA4907@ime.usp.br>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net> <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br> <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net> <Pine.LNX.4.60.0509272139220.18464@poirot.grange> <20051001211543.GB6397@ime.usp.br> <Pine.LNX.4.60.0510090031550.16544@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.60.0510090031550.16544@poirot.grange>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guennadi.

On Oct 09 2005, Guennadi Liakhovetski wrote:
> Sorry, was away for a week.

No problems. I've been quite busy also.

> On Sat, 1 Oct 2005, [iso-8859-1] Rog?rio Brito wrote:
> 
> > > Try removing the 256MB module?...
> > 
> > Right now, I'm only using one 512MB module, but after I have already
> > paid for the second one, and it wasn't cheap. :-(
> 
> Wasn't it 512 + 512 + 256 MB modules that you had?

Exactly, but I didn't manage to get the 2x512MB modules useable in my
machine. In fact, sometimes the machine wouldn't even POST with the two
modules, but as soon as I removed any one of them, the machine was back
to normal.

> I just suggested removing only one 256MB module and testing with 2 x
> 512MB. Which on the one hand wouldn't be that bad as only having
> 512MB, and on the other hand just for a test...

Right now, I am using 512 + 256 running at PC100 speeds, with latencies
all set to 3-3-3. Now, it seems to run stably, but is slower than what I
would like it to run, of course.

I will still keep trying some combinations, but some of them seem
definitely ruled out (like having both 512 MB modules at the same time).


Thank you very much for your comments, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
