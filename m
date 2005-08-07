Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752734AbVHGU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbVHGU6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbVHGU6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:58:42 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:34394 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752734AbVHGU6l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:58:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TOfRkAtHWR39F1s9Y7cOPbz6FQ1GP4THENCJEnO0O2GnTvHT8qiYeSX4OPaPCUw8+S5yKTTFNHGmopUsWczR6h0MzNWha2zBLv1fcyuMZYCQ5uvZP3sCmaRoxqwHa/f8g1hxukoR3IdC2lYxHNxm8fSevdr/if1iDSCO441v9To=
Message-ID: <1ed860e30508071358318fea@mail.gmail.com>
Date: Sun, 7 Aug 2005 16:58:39 -0400
From: Raymond Lai <raymond.kk.lai@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: any update on the pcmcia bug blocking Audigy2 notebook sound card driver development
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-audio-dev@music.columbia.edu,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <1123440095.12766.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	 <20050807104332.320aec48.akpm@osdl.org>
	 <1123440095.12766.3.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Lee. That's the bug I'm referring to.

It would be great if laptop users can enjoy the higher sound quality
the Audigy2 pcmcia sound card offers, which is way better than the
builtin onboard sound.

Raymond


On 8/7/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sun, 2005-08-07 at 10:43 -0700, Andrew Morton wrote:
> > Raymond Lai <raymond.kk.lai@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > I remember there's a kernel pcmcia bug preventing the development for
> > > the Audigy2 pcmcia notebook sound card driver.
> > >
> > > See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> > >
> > > Is there any new updates on the situation? Has the bug been fixed? or
> > > anyone working on it?
> > >
> >
> > Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?
> 
> No, that was a known issue that is resolved in 2.6.13-rc*.  This is the
> bug he's referring to:
> 
> http://lkml.org/lkml/2005/7/11/265
> 
> Looks like James never followed up, probably due to OLS.
> 
> Lee
> 
>
