Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbTEWRlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTEWRlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:41:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45478 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264106AbTEWRli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:41:38 -0400
Date: Fri, 23 May 2003 14:52:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: "'Scott McDermott'" <vaxerdec@frontiernet.net>,
       "'Marc-Christian Petersen'" <m.c.p@wolk-project.de>,
       "'Sven Krohlas'" <darkshadow@web.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <002b01c32107$b5686030$020b10ac@pitzeier.priv.at>
Message-ID: <Pine.LNX.4.55L.0305231448440.32556@freak.distro.conectiva>
References: <002b01c32107$b5686030$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 May 2003, Oliver Pitzeier wrote:

> Scott McDermott wrote:
> > Marc-Christian Petersen on Thu 22/05 17:31 +0200:
> > > http://people.freebsd.org/~gibbs/linux/SRC/
> >
> > Why isn't this in mainline again? It seems everyone and
> > their grandmother needs it for their machine not to fall
> > apart.  I know I do, my machine won't even run for more than
> > a few dozen seconds without it.  Busy NFS server with it
> > (I'm using a 7892 HBA)
>
> Thanks for this information. Now it would be great to get a statement from
> Marcelo, wouldn't it?
> Why did you release the -rc3 without this? I believe there are more people like
> me, that have such problems and do not even know about it.
>


Because it was too late for it to be included. It is a NEW driver and
there is no WAY I will include it except early -pre's.
