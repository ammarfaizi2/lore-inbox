Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318536AbSIFMVY>; Fri, 6 Sep 2002 08:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318539AbSIFMVY>; Fri, 6 Sep 2002 08:21:24 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:15090
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318536AbSIFMVX>; Fri, 6 Sep 2002 08:21:23 -0400
Subject: Re: 2.5.xx kernels won't run on my Athlon boxes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirk Reiser <kirk@braille.uwo.ca>
Cc: Hell.Surfers@cwctv.net, linux-kernel@vger.kernel.org
In-Reply-To: <x765xj9wgg.fsf@speech.braille.uwo.ca>
References: <0a0c35552230592DTVMAIL9@smtp.cwctv.net>
	<1031272848.7367.33.camel@irongate.swansea.linux.org.uk> 
	<x765xj9wgg.fsf@speech.braille.uwo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 13:26:52 +0100
Message-Id: <1031315212.9945.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 12:41, Kirk Reiser wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > That wont help because he has 2.5 problems. However the 2.5 IDE for < 33
> > is known hosed for some cases anyway.
> 
> Can you tell me more?  I'm trying to figure out just what else to try
> I haven't already tried.  I can't be the only person experiencing
> this.  I mean I'm having the same problem on two separate computers
> build with the same components.

There was a lot of IDE rewriting for 2.5. 2.5 IDE doesnt work for lots
of cases. If you want working IDE run 2.4

