Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293068AbSCFC0J>; Tue, 5 Mar 2002 21:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293075AbSCFC0A>; Tue, 5 Mar 2002 21:26:00 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:58888
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S293068AbSCFCZu>; Tue, 5 Mar 2002 21:25:50 -0500
Date: Wed, 6 Mar 2002 03:24:45 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [SiS IDE] 530,540,620 5511,5513 testers wanted
Message-ID: <20020306032445.C9217@bouton.inet6-interne.fr>
Mail-Followup-To: Andre Hedrick <andre@linuxdiskcert.org>,
	=?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020306024001.A9217@bouton.inet6-interne.fr> <Pine.LNX.4.10.10203051746580.18118-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10203051746580.18118-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Tue, Mar 05, 2002 at 05:50:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 05:50:59PM -0800, Andre Hedrick wrote:
> 
> Lionel,
> 
> Please add your name to the Maintainer List for the SIS5513 chipset code.
> [...]

If no show-stopper bugreport comes in in the following days, I'll submit a
patch (marked sis5513.c v0.13 final) with debug mode deactivated to lkml,
you and Marcelo that will address this.

So lkml SiS chipset owners, please stress the 20020304_1 patch
available at:
http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html

As I lack test reports on some chip generations, if people with a SiS530,
540,620 or SiS5511,5513 chip would take the time to mail me test results
with this patch, that would be perfect.

LB.
