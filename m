Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSIFMgG>; Fri, 6 Sep 2002 08:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSIFMgF>; Fri, 6 Sep 2002 08:36:05 -0400
Received: from speech.braille.uwo.ca ([129.100.109.30]:13521 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S318560AbSIFMgE>; Fri, 6 Sep 2002 08:36:04 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hell.Surfers@cwctv.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.xx kernels won't run on my Athlon boxes
References: <0a0c35552230592DTVMAIL9@smtp.cwctv.net>
	<1031272848.7367.33.camel@irongate.swansea.linux.org.uk>
	<x765xj9wgg.fsf@speech.braille.uwo.ca>
	<1031315212.9945.35.camel@irongate.swansea.linux.org.uk>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 06 Sep 2002 08:40:41 -0400
In-Reply-To: <1031315212.9945.35.camel@irongate.swansea.linux.org.uk>
Message-ID: <x7sn0n8f5i.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> There was a lot of IDE rewriting for 2.5. 2.5 IDE doesnt work for lots
> of cases. If you want working IDE run 2.4

I do run 2.4 on most of my systems.  Thing is see, console code was
changed in 2.5 and so speakup doesn't work with it anymore.  I can't
very well rewrite speakup to work again on 2.5.x kernels if I'm
running 2.4.

I don't even mind providing error reports and the like but I have to
find someway to make bug reports consistant and reliable enough to be
useful to folks.

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
