Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbTAQLD4>; Fri, 17 Jan 2003 06:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAQLDx>; Fri, 17 Jan 2003 06:03:53 -0500
Received: from [66.70.28.20] ([66.70.28.20]:63751 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267489AbTAQLCs>; Fri, 17 Jan 2003 06:02:48 -0500
Date: Fri, 17 Jan 2003 11:08:24 +0100
From: DervishD <raul@pleyades.net>
To: Tethys <tet@accucard.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030117100824.GA47@DervishD>
References: <20030116130013.GE1358@DervishD> <200301161315.h0GDFLM27487@isengard.accucard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200301161315.h0GDFLM27487@isengard.accucard.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Tethys :)

> >    See the previous messages. I want to avoid mounting /proc.
> Yes, I'd read them, but obviously missed the need to avoid /proc.

    Let's say that there is no need to avoid /proc, but things like
those must be the last resort, because the problems they introduce
are bigger than the problem they help to solve :)

> I assume the idea behind this is for some very low memory embedded
> device. Sounds interesting (and actually, one of the few legitimate
> reasons I've seen for wanting to override argv[0]!).

    Yes, vcinit was designed for a reduced embedded device. And it
was very interesting (well, at first...) but now the work rests in
the heaven of abandonware ;)))

> Without /proc, I can't think of any easy way of doing it, short of
> wading through /dev/kmem :-)

    Ouch! ;)))

    Raúl
