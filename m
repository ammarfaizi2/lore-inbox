Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWAUBxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWAUBxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWAUBxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:53:13 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:23763 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932296AbWAUBxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:53:12 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Lee Revell <rlrevell@joe-job.com>
To: andersen@codepoet.org
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <20060120025513.GA2438@codepoet.org>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain>
	 <1137709308.8471.77.camel@localhost.localdomain>
	 <20060119224501.GC19398@stusta.de>  <20060120025513.GA2438@codepoet.org>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 20:53:02 -0500
Message-Id: <1137808385.3241.78.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 19:55 -0700, Erik Andersen wrote:
> On Thu Jan 19, 2006 at 11:45:01PM +0100, Adrian Bunk wrote:
> > config SOUND_WAVEARTIST
> >         tristate "Netwinder WaveArtist"
> >         depends on ARM && SOUND_OSS && ARCH_NETWINDER
> >         help
> >           Say Y here to include support for the Rockwell WaveArtist sound
> >           system.  This driver is mainly for the NetWinder.
> 
> I own two netwinders (strongArm SA110) and I would be glad to
> fire them up to test things if someone feels like writing a
> driver....

I guess you are not volunteering to do it yourself...?

If you feel like tackling this google "Writing an ALSA driver", it
basically walks you through the process, you could do it in a weekend
with the source to the OSS driver in hand.

Lee

