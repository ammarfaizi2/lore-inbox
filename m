Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSG3QDY>; Tue, 30 Jul 2002 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSG3QDY>; Tue, 30 Jul 2002 12:03:24 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57231 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318314AbSG3QDX>; Tue, 30 Jul 2002 12:03:23 -0400
Subject: Re: [TRIVIAL] Anton Blanchard is 2.5 PPC64 maintainer
From: Todd Inglett <tinglett@vnet.ibm.com>
To: Rusty Trivial Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020730030327.F38724429@lists.samba.org>
References: <20020730030327.F38724429@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Jul 2002 11:06:43 -0500
Message-Id: <1028045204.991.26.camel@q.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 21:43, Rusty Trivial Russell wrote:
> From:  Rusty Russell <rusty@rustcorp.com.au>
> 
>   Anton is the one all the mail goes to, and who sends the patches to
>   Linus.  David is the 2.4 maintainer.

I think you ought to clear this with Dave.  He's been swamped with 2.4
work, but I don't think he has ever planned to give up maintainership
just because this is 2.5.

There's no denying that Anton's been doing lots of work keeping 2.5
ppc64 up-to-date but that doesn't automatically mean maintainership
should swap.

-todd


> --- trivial-2.5.29/MAINTAINERS.orig	Tue Jul 30 12:15:14 2002
> +++ trivial-2.5.29/MAINTAINERS	Tue Jul 30 12:15:14 2002
> @@ -960,8 +960,8 @@
>  S:	Maintained
> 
>  LINUX FOR 64BIT POWERPC
> -P:	David Engebretsen
> -M:	engebret@us.ibm.com
> +P:	Anton Blanchard
> +M:	anton@samba.org
>  W:	http://linuxppc64.org
>  L:	linuxppc64-dev@lists.linuxppc.org
>  S:	Supported


