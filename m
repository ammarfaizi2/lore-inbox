Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbSLQTSj>; Tue, 17 Dec 2002 14:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSLQTSi>; Tue, 17 Dec 2002 14:18:38 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1454 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S266908AbSLQTSh>; Tue, 17 Dec 2002 14:18:37 -0500
Date: Tue, 17 Dec 2002 14:28:34 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: My fixes to ide-tape in 2.4.20-ac2
In-Reply-To: <20021217142235.C8233@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.50L.0212171427080.26120-100000@freak.distro.conectiva>
References: <20021213224424.A3446@devserv.devel.redhat.com>
 <Pine.LNX.4.50L.0212162248480.31876-100000@freak.distro.conectiva>
 <20021217142235.C8233@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Pete Zaitcev wrote:

> > Date: Mon, 16 Dec 2002 22:49:35 -0200 (BRST)
> > From: Marcelo Tosatti <marcelo@conectiva.com.br>
>
> > > I checked that my fixes were not corrected by Alan Stern,
> > > and re-diffed them against 2.4.20-ac2. I think it would
> > > be right if Alan (Cox :-) applied this patch to -ac3 or something.
> > > Marcelo agreed to take it many times but forgot to actually apply.
> >
> > I haven't applied them because I was afraid they could break something.
> >
> > Great that now its been tested in -ac.
>
> Yes, Alan saves the day. However, I would think this is what your
> -pre series were supposed to do. Add fixes, see if they break things.
> Release more often. If patches regress, remove them. Obviously, your
> master vision is different, but personally I think it's unfortunate.

Pete,

I'm not master. Most people here know much more than what I do.

