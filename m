Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWEaEq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWEaEq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWEaEq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:46:58 -0400
Received: from smtp.enter.net ([216.193.128.24]:58125 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751688AbWEaEq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:46:57 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 31 May 2006 00:45:56 +0000
User-Agent: KMail/1.8.1
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605310026.01610.dhazelton@enter.net> <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
In-Reply-To: <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605310045.56962.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 May 2006 04:39, Jon Smirl wrote:
> On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> > On Wednesday 31 May 2006 04:16, Jon Smirl wrote:
> > > On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> > > > Like I've said, this has gone onto my list. Now to get back to the
> > > > code... I really do want to see about getting this stuff into the
> > > > kernel ASAP.
> > >
> > > You might want to leave the DRM hot potato alone for a while and just
> > > work on fbdev. Fbdev is smaller and it is easier to get changes
> > > accepted.
> >
> > Yes, but I have accepted that there is a certain direction and order the
> > maintainers want things done in. For this reason I can't just leave DRM
> > alone.
>
> fbdev (Antonino A. Daplas <adaplas@gmail.com>) and DRM (Dave Airlie
> <airlied@gmail.com>) have two different maintainers. I have not seen
> Tony comment on what he thinks of Dave's plans so I don't know what
> his position is how driver merging can be acomplished.

True, and neither have I. But lacking Tony's comment I have to trust Dave's 
statement that the direction he has pointed me in is the one settled on at 
the last Kernel Summit.

DRH
