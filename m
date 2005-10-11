Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVJKAaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVJKAaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVJKAaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:30:25 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:38385 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751315AbVJKAaY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:30:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U1FKPR2sKLEqmIJWulzEkJfDfk2KgrJnekUuw9MUyKDuYd6U1MOWMPflEv9oxUe4UxI6c6uQY79yD993A2LeJCbP+v+Q/5CtfnfIPuehjnSCqfVVSweAFDRXQkyccyNVwjDuYavv85R8sXJWJ1vV9GKMbnt65SdgdF+/O/oxPBg=
Message-ID: <21d7e9970510101730n790dff2dk5dd0cd333d10d67b@mail.gmail.com>
Date: Tue, 11 Oct 2005 10:30:23 +1000
From: Dave Airlie <airlied@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: DRM - changes in 2.6.14-rc1 lock display
In-Reply-To: <20051010153949.GA3700@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051010153949.GA3700@irc.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Recently I've noticed, that running any OpenGL application in X11
> (screensaver, glxgears, Quake 3 Arena) locks display. System is working,
> but display remains locked even if I ssh and kill X.
>
>  Kernel 2.6.13 works OK. Kernel 2.6.14-rc1 and later locks up. I
> couldn't find any git snapshots between 2.6.13 and .14-rc1.
>
>  System is Slackware, x11-6.8.2, Matrox G550 with mga driver.
>

Hi

Can you send me an Xorg.0.log from 2.6.13 and one from 2.6.14-rc1?

Dave.
