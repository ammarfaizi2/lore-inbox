Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292932AbSBVQy4>; Fri, 22 Feb 2002 11:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292931AbSBVQyr>; Fri, 22 Feb 2002 11:54:47 -0500
Received: from dns.logatique.fr ([213.41.101.1]:6901 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S292930AbSBVQyc>; Fri, 22 Feb 2002 11:54:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: andersen@codepoet.org, Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.18-rc2-ac2
Date: Fri, 22 Feb 2002 17:53:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202212020.g1LKK2209402@devserv.devel.redhat.com> <20020221213358.GA10259@codepoet.org>
In-Reply-To: <20020221213358.GA10259@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020222165150.C8C3F23CCD@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mm. excerpt from alan's patch :


----------------------------------
 PATCHLEVEL = 4
-SUBLEVEL = 17
-EXTRAVERSION =
+SUBLEVEL = 18
+EXTRAVERSION = -rc2-ac2
----------------------------------------


so I infere the patch is against 2.4.17 vanilia
I would have guessed it was against 2.4.18-rc2, though.

Thomas

On Thursday 21 February 2002 22:33, Erik Andersen wrote:
> On Thu Feb 21, 2002 at 03:20:02PM -0500, Alan Cox wrote:
> > [+ indicates stuff that went to Marcelo, o stuff that has not,
> >  * indicates stuff that is merged in mainstream now, X stuff that proved
> >    bad and was dropped out]
> >
> > Linux 2.4.18rc2-ac2
>
> Tried it.  Doesn't apply at all to linux-2.4.17.tar.bz2
> plus patch-2.4.18-rc2.bz2 -- perhaps you diffed against
> something else?
>
>  -Erik
