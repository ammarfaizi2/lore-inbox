Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264918AbSJ3VFa>; Wed, 30 Oct 2002 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSJ3VF3>; Wed, 30 Oct 2002 16:05:29 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58525 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S264918AbSJ3VF3>; Wed, 30 Oct 2002 16:05:29 -0500
Date: Wed, 30 Oct 2002 18:35:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mitch Adair <mitch@theneteffect.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc1 and i810_audio
In-Reply-To: <1035931140.1255.27.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0210301834590.10782-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 Oct 2002, Alan Cox wrote:

> On Tue, 2002-10-29 at 17:33, Mitch Adair wrote:
> > I notice that rc1 doesn't have Juergen Sawinski's updates (0.23/0.24)
> > to i810_audio that allow ICH4 (i845) based chipsets to work.  They've
> > been in AC for a while (since pre5 I think) - just wondering if that is a
> > merge problem or if there is something else the matter (they seem to
> > work great on the i845E I've got.)
>
> They could go in, they seem to work fine. Marcelo ?

I'll take a look at those updates in -ac.

