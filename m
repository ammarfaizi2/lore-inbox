Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271702AbTGRM0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271716AbTGRM0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:26:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52109 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S271702AbTGRM0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:26:04 -0400
Date: Fri, 18 Jul 2003 09:33:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Arnaud Ligot <spyroux@freegates.be>
Subject: Re: Fw: about the crash of the 2.4.20
In-Reply-To: <016401c34cad$5b1f58a0$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307180933190.6642@freak.distro.conectiva>
References: <016401c34cad$5b1f58a0$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Jul 2003, Jim Gifford wrote:

>
> ----- Original Message -----
> From: "Arnaud Ligot" <spyroux@freegates.be>
> To: "Jim Gifford" <maillist@jg555.com>
> Sent: Thursday, July 17, 2003 1:59 PM
> Subject: about the crash of the 2.4.20
>
>
> Le jeu 17/07/2003 à 21:50, Jim Gifford a écrit :
> > ----- Original Message -----
> > From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> > To: "Jim Gifford" <maillist@jg555.com>
> > Cc: "lkml" <linux-kernel@vger.kernel.org>
> > Sent: Thursday, July 17, 2003 11:46 AM
> > Subject: Re: 2.4.22-pre6 deadlock
> >
> >
> > >
> > > Jim,
> > >
> > > I just noticed your kernel is tained.
> > >
> > > For what reason?
> > >
> > >
> >
> > The only patches I use are for netfilter options and the updated megaraid
> > driver everything else is stock.
> >
> > Do you think some of the netfilter options could be causing the problems??
> I don't know I use a vanilla kernel (without any patch) and my problem
> seems to come from the Reiserfs support.
>
>
> Marcelo,
>     I thought you should see this.

Thanks Jim.

Arnaud, could you explain your problem in more detail please?

