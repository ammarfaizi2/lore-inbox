Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272904AbTG3OdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272905AbTG3OdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:33:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52354 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272904AbTG3OdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:33:15 -0400
Date: Wed, 30 Jul 2003 11:28:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ROOT NFS fixes ...
In-Reply-To: <Pine.LNX.4.55L.0307301107080.29393@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.55L.0307301128200.29648@freak.distro.conectiva>
References: <20030729211521.GA19594@www.13thfloor.at>
 <Pine.LNX.4.55L.0307301057030.29278@freak.distro.conectiva>
 <20030730140739.GA24587@www.13thfloor.at> <Pine.LNX.4.55L.0307301107080.29393@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jul 2003, Marcelo Tosatti wrote:

>
> On Wed, 30 Jul 2003, Herbert Pötzl wrote:
>
> > On Wed, Jul 30, 2003 at 10:57:52AM -0300, Marcelo Tosatti wrote:
> > >
> > >
> > > On Tue, 29 Jul 2003, Herbert Pötzl wrote:
> > >
> > > >
> > > > Hi Marcelo!
> > > >
> > > > just verified that the NFS root bug-fix was not
> > > > included in 2.4.22-pre9, unfortunately I have
> > > > to ask you again, why you do not want to fix
> > > > this issue in 2.4.22 ...
> > > >
> > > > I do not understand why Trond obviously is
> > > > ignoring my mails, regarding this particular
> > > > issue, maybe he is just too busy to look at
> > > > four twoline changes, and more, I do not
> > > > understand why this isn't accepted into the
> > > > marcelo kernel tree, as it obviously fixes a
> > > > misbehaviour?
> > > >
> > > > please explain!
> > > >
> > > > It is okay for me, if your argumentation goes
> > > > like "I don't like you, that's reason enough
> > > > for me to not include your patches ...", but I
> > > > would like to know ...
> > >
> > > I do not consider the patch critical enough.
> > >
> > > Get it in 2.5 first, then come back :)
> >
> > I hope this is a joke, and you are still reading
> > your mail ...
>
> No, this is not a joke, at all.
>
> Let me repeat: I (and Trond) do not consider this patch critical.

Ok, I'm wrong. I just read Trond's mail saying the patch is OK.

I'll apply it to -pre10.

