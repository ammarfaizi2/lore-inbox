Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272875AbRISSyn>; Wed, 19 Sep 2001 14:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272836AbRISSyd>; Wed, 19 Sep 2001 14:54:33 -0400
Received: from mail.ask.ne.jp ([203.179.96.3]:42984 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S272822AbRISSy3>;
	Wed, 19 Sep 2001 14:54:29 -0400
Date: Thu, 20 Sep 2001 03:55:47 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: min/max and all that jazz
Message-Id: <20010920035547.7943346b.bruce@ask.ne.jp>
In-Reply-To: <20010919115917.A12129@maclaurence.math.u-psud.fr>
In-Reply-To: <20010919115917.A12129@maclaurence.math.u-psud.fr>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001 11:59:17 +0200
Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> gcc has a warning option -Wsign-compare (not turned on by -Wall):

[SNIP]

> This might pick up some errors of the kind the new min/max macros
> are trying to catch...
>
> PS: please CC any comments to me, since I'm not subscribed to the list.

Apparently not... During the big flamefest over min()/max(), Linus expressed a
fairly clear dislike for -Wsign-compare ;)

