Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272042AbTGYMaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272043AbTGYMaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:30:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14227 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272042AbTGYM36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:29:58 -0400
Date: Fri, 25 Jul 2003 09:41:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre8
In-Reply-To: <3F20A0DB.2000101@vgertech.com>
Message-ID: <Pine.LNX.4.55L.0307250939590.12476@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307241721130.7875@freak.distro.conectiva>
 <3F20A0DB.2000101@vgertech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Jul 2003, Nuno Silva wrote:

> Hi Marcelo!
>
> Marcelo Tosatti wrote:
> > Hello,
> >
> > Here goes -pre8. It contains network driver updates, IEEE1394 update, a
> > POSIX compliance fix introduced by the execve() security fixes during
> > early -pre, amongst others.
> >
>
> [..snip..]
>
> Can you, please(!!), tell me if this release fixes all the known
> security problems that compromise root? :)
>
> There's a lot of information available and some people says that
> everything is "good" in recent vanilla-preX. Others says it isn't.

As far as I know, all known security problems are fixed. All security
fixes from -ac are in mainline.

So if anyone knows any security problem which is not fixed yet, please
inform me.
