Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBIJqE>; Fri, 9 Feb 2001 04:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBIJpy>; Fri, 9 Feb 2001 04:45:54 -0500
Received: from www.wen-online.de ([212.223.88.39]:28179 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129027AbRBIJpu>;
	Fri, 9 Feb 2001 04:45:50 -0500
Date: Fri, 9 Feb 2001 10:45:48 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: christophe barbe <christophe.barbe@inup.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <20010209091227.A28797@pc8.inup.com>
Message-ID: <Pine.Linu.4.10.10102090955270.1886-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, christophe barbe wrote:

> On ven, 09 fév 2001 08:03:14 Mike Galbraith wrote:
> > I hope that nothing like this is _ever_ integrated (and doubt I need
> > be concerned;).  IMHO, hiding output from users arrogantly assumes
> > that they are too stupid/ignorant to have any use for such information.
> 
> Most user don't want to learn the internal stuff of their OS. They only want to use it and assume (or would like to) that everything is ok. 
> You hope graphic boot capability will never be integrated in the kernel but I'm sure you are aware of what is an "OPTION".

I give users more credit in the curiosity/observation department.  In
my experience, when a user fires up his/her box, independent of OS,
they watch it pretty closely.  This behavior begins roughly the first
time they lose a chunk of work ;-)

Whether the boot process is graphic or text doesn't matter.. some will
watch it and some will ignore it.

If I were an employer, I'd feel a lot better about my staff if I walk
by and catch them staring blankly at cryptic text vs a splash screen.

> Sure it's not a vital need. Distribution makers can already add this on their kernels (and in fact they do that, per example by using aurora). But it could result in a proper implementation. Required modifications are really small.

Yup.  Distributors can add whatever whistles/bells that fit their needs.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
